# KEDA and Karpenter: Complete Guide
## Installation, Objects, Usage, and Cost Optimization

## Purpose

This document explains everything needed to fully understand KEDA and Karpenter, including:

- what KEDA is
- what Karpenter is
- how each one is installed
- what objects are created after installation
- what those objects do
- how each one is used in practice
- how they optimize cost
- how they work together
- what trade-offs and limitations exist

---

# 1. Big Picture

KEDA and Karpenter solve two different scaling problems in Kubernetes.

## KEDA
KEDA works at the **application/pod layer**.

It answers:

> How many replicas of this application should run right now?

KEDA can scale workloads up and down based on triggers such as:

- CPU
- memory
- queue length
- external events
- metrics from cloud services or messaging systems

Most importantly, KEDA can often scale workloads **down to zero**, depending on the trigger and configuration.

---

## Karpenter
Karpenter works at the **node/infrastructure layer**.

It answers:

> What worker nodes should exist in the cluster right now?

Karpenter creates nodes when pods cannot be scheduled and removes or consolidates nodes when capacity is no longer needed.

---

## Why they are powerful together

They optimize different layers of waste:

- **KEDA removes unnecessary pods**
- **Karpenter removes unnecessary nodes**

That means:

- KEDA reduces idle workload cost
- Karpenter reduces idle infrastructure cost

Together, they are very powerful in cost-optimized non-production Kubernetes environments.

---

# 2. What Problem KEDA Solves

Without KEDA, many Kubernetes workloads are configured like this:

- fixed replica count
- always-on pods
- no awareness of real demand
- pods running even when nobody is using the service

This creates waste, especially in:

- dev environments
- staging environments
- preview environments
- internal tools
- event-driven applications

## Example problem
Imagine an internal API used only a few times per day.

Without KEDA:
- 1 or 2 pods stay running all day
- CPU/memory requests stay allocated
- nodes stay under pressure

With KEDA:
- the app can scale to zero when idle
- it starts again only when needed

That is the cost optimization.

---

# 3. What Problem Karpenter Solves

Without Karpenter, clusters often suffer from:

- empty nodes still running
- half-used nodes
- badly sized nodes
- slow cluster autoscaling behavior
- excess capacity after traffic drops

Traditional cluster scaling often leaves waste behind.

## Example problem
Imagine a dev cluster that scaled up during working hours.

After traffic drops:
- some pods are gone
- but several nodes remain underused or empty
- the company keeps paying for them

With Karpenter:
- empty or underutilized nodes can be removed or consolidated

That is the cost optimization.

---

# 4. Key Difference Between KEDA and Karpenter

## KEDA
Scales **pods**

## Karpenter
Scales **nodes**

## Simple mental model

### KEDA says:
> This app does not need 3 pods anymore. Reduce it to 0 or 1.

### Karpenter says:
> Now that fewer pods exist, some nodes are no longer needed. Remove or consolidate them.

---

# 5. KEDA Installation

KEDA is usually installed as a **cluster add-on**, most commonly with Helm.

## Step 1: Add the Helm repository

```bash
helm repo add kedacore https://kedacore.github.io/charts
helm repo update
```
## Step 2: Install KEDA
```shell
helm install keda kedacore/keda \
  --namespace keda \
  --create-namespace
```

## What this does

This installs KEDA into the cluster, usually into its own namespace:

 - keda

It deploys:

- the KEDA operator/controller
- webhooks 
- CRDs such as:
  - ScaledObject 
  - ScaledJob 
  - authentication-related resources

## Step 3: Verify the installation
```shell
kubectl get pods -n keda
kubectl get crds | grep keda
```

# 6. What Happens After KEDA Installation

- Installing KEDA is only the first step.

> KEDA installation gives the cluster the ability to understand KEDA objects, but KEDA does not scale your apps automatically unless you create KEDA resources for them.
> The most common object you create after installation is:

- `ScaledObject`

So the real order is:

- install KEDA 
- deploy your application 
- create a ScaledObject 
- KEDA begins scaling that application
# 7. KEDA ScaledObject
- Example
```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: my-app-scaler
  namespace: my-app
spec:
  scaleTargetRef:
    name: my-app
  minReplicaCount: 0
  maxReplicaCount: 5
  triggers:
    - type: cpu
      metadata:
        type: Utilization
        value: "70"
```

- What `ScaledObject` does

A `ScaledObject` tells KEDA:

- which workload to scale
- how low it may scale
- how high it may scale
- what trigger should control the scaling

It is the actual scaling policy for a workload.

### Field-by-field explanation
`apiVersion: keda.sh/v1alpha1`
- This is the API version for the KEDA custom resource.

`kind: ScaledObject`

- This tells Kubernetes that this is a KEDA scaling object for a workload.

`metadata.name`

- The name of the scaling object itself.

`metadata.namespace`

- The namespace where this object lives.
Usually, the workload it scales is in the same namespace.

`scaleTargetRef.name: my-app`

- This tells KEDA which workload to scale.

Normally this refers to a `Deployment`, unless specified otherwise.

Example:

```yaml
kind: Deployment
metadata:
  name: my-app
  namespace: my-app
```

In that case, KEDA will scale the deployment named `my-app`.

`minReplicaCount: 0`

- This is one of the most important fields.

It means:

- KEDA may scale this workload all the way down to 0 replicas

That is where scale-to-zero comes from.

`maxReplicaCount: 5`

This tells KEDA:

- do not scale this workload above 5 replicas
triggers

This defines what signal causes scaling.

```yaml
triggers:
  - type: cpu
    metadata:
      type: Utilization
      value: "70"
```
This means:

- monitor CPU utilization
- when usage crosses the threshold, adjust scaling

# 8. How KEDA Works at Runtime

The runtime flow looks like this:

- the app exists in the cluster 
- the ScaledObject exists in the cluster 
- KEDA watches the trigger 
- KEDA evaluates demand 
- if demand is low, KEDA reduces replicas 
- if demand disappears and minReplicaCount: 0, KEDA may scale to zero 
- when demand returns, KEDA scales back up
# 9. How KEDA Optimizes Cost

KEDA optimizes cost by reducing idle workload cost.

What it reduces
- unnecessary pods
- unnecessary CPU consumption
- unnecessary memory allocation
- idle replica cost
- cluster pressure caused by low-use services

Why this matters

- If a service is not being used, it should not keep running replicas unless there is a real reason to keep it warm.

- In dev and non-production environments, this is often one of the biggest silent waste areas.

### Cost optimization summary for KEDA

KEDA reduces:

- idle pod cost
- wasted app runtime cost
- unnecessary node pressure
# 10. Karpenter Installation

- Karpenter is also installed as a cluster add-on, but it is more complex than KEDA because it needs cloud-provider integration.

- The most common documented setup is on AWS EKS.

## Step 1: Install Karpenter controller

Karpenter is usually installed with Helm into its own namespace, often:

- karpenter

The exact Helm installation can vary by version and provider setup, but conceptually it installs:

- Karpenter controller
- CRDs
- RBAC resources
## Step 2: Configure cloud permissions

This is critical.

Karpenter cannot create nodes unless it has the required cloud permissions.

On AWS, this usually means:

- IAM permissions for Karpenter controller
- node IAM role for launched worker nodes

Without this, Karpenter is installed but cannot actually provision capacity.

## Step 3: Create infrastructure definition object

After installation, Karpenter still needs to know:

- which subnets to use
- which security groups to use
- what IAM role nodes should use
- what AMI family to boot

On AWS, this is done using:

- `EC2NodeClass`
## Step 4: Create capacity policy object

After the infrastructure definition exists, you define how nodes should be created and managed.

This is done using:

- `NodePool`
## Step 5: Deploy workloads

- Once workloads create demand, Karpenter reacts by provisioning nodes if needed.

# 11. What Happens After Karpenter Installation

Installing Karpenter is not enough by itself.

Karpenter needs configuration objects after installation.

For AWS, the common order is:

- install Karpenter
- configure IAM/cloud integration
- create EC2NodeClass
- create NodePool
- deploy workloads
- Karpenter begins provisioning and consolidating nodes

So just like KEDA, installation is only the start.

# 12. Karpenter EC2NodeClass
Example
```yaml
apiVersion: karpenter.k8s.aws/v1
kind: EC2NodeClass
metadata:
  name: default
spec:
  amiFamily: AL2023
  role: KarpenterNodeRole
  subnetSelectorTerms:
    - tags:
        karpenter.sh/discovery: my-eks-cluster
  securityGroupSelectorTerms:
    - tags:
        karpenter.sh/discovery: my-eks-cluster
```
What `EC2NodeClass` does

This object tells Karpenter how AWS nodes should be launched.

Think of it as:

> the AWS infrastructure template for Karpenter-managed nodes

It defines:

- networking placement
- IAM role
- AMI family
- security groups

### Field-by-field explanation
`apiVersion: karpenter.k8s.aws/v1`

- AWS-specific Karpenter API version.

`kind: EC2NodeClass`

- This is the AWS infrastructure definition object.

`metadata.name: default`

- This is the name of the object.
- `NodePool` will refer to this by name.

`amiFamily: AL2023`

- This defines what AMI family the launched nodes should use.

In this case:

- Amazon Linux 2023
`role: KarpenterNodeRole`

- This is the IAM role the nodes should use when launched.

`subnetSelectorTerms`

- This tells Karpenter which subnets it may use when creating nodes.

- In this example, it selects subnets by tag.

`securityGroupSelectorTerms`

- This tells Karpenter which security groups to attach to the nodes.

- Again, it selects them by tag.

### What problem EC2NodeClass solves

Without it, Karpenter would not know:

- where to place nodes
- what network settings to use
- what IAM role to assign
- what image family to boot

So `EC2NodeClass` solves the infrastructure-definition problem.

# 13. Karpenter NodePool
Example
```yaml
apiVersion: karpenter.sh/v1
kind: NodePool
metadata:
  name: default
spec:
  template:
    spec:
      nodeClassRef:
        group: karpenter.k8s.aws
        kind: EC2NodeClass
        name: default
      requirements:
        - key: kubernetes.io/arch
          operator: In
          values: ["amd64"]
  disruption:
    consolidationPolicy: WhenEmptyOrUnderutilized
```
What `NodePool` does

This object tells Karpenter:

- what node policy to use
- which node class to reference
- what constraints apply to created nodes
- how consolidation behavior should work

It is the main policy object for Karpenter-managed capacity.

### Field-by-field explanation
`apiVersion: karpenter.sh/v1`

- Karpenter API version for node capacity policy objects.

`kind: NodePool`

- This is the Karpenter object that defines node provisioning and disruption behavior.

`metadata.name: default`

- The name of the NodePool.

`nodeClassRef`

- This is one of the most important fields.

```yaml
nodeClassRef:
  group: karpenter.k8s.aws
  kind: EC2NodeClass
  name: default
```

This means:

- use the EC2NodeClass named default
- therefore use its AWS settings for launched nodes

`requirements`

- These define node constraints.

example:

```yaml
- key: kubernetes.io/arch
  operator: In
  values: ["amd64"]
```

This means:

- only allow amd64 architecture nodes

You can think of this as part of the node selection rules.

`disruption.consolidationPolicy: WhenEmptyOrUnderutilized`

- This is the main cost-optimization field in your example.

It means:

- if nodes are empty, Karpenter may remove them
- if nodes are underutilized, Karpenter may consolidate them

This is how Karpenter reduces wasted infrastructure.

# 14. How Karpenter Works at Runtime

The runtime flow looks like this:

- workloads are deployed
- some pods cannot be scheduled
- Karpenter evaluates NodePool
- Karpenter uses nodeClassRef to find the infrastructure settings
- Karpenter creates matching capacity
- nodes join the cluster
- workloads get scheduled
- when demand drops, nodes may become empty or underused
- Karpenter consolidates or removes them
# 15. How Karpenter Optimizes Cost

Karpenter optimizes cost by improving node capacity efficiency.

What it reduces
- empty nodes
- underutilized nodes
- badly sized capacity
- stale capacity left behind after demand falls

Why this matters

- Even if your pods are scaled correctly, the cluster can still waste money if old or half-empty nodes remain alive.

- Karpenter helps clean that up.

Cost optimization summary for Karpenter

Karpenter reduces:

- wasted node cost
- excess infrastructure cost
- poor capacity utilization
# 16. How KEDA and Karpenter Work Together

- This is the most important combined concept.

### First layer: KEDA

- KEDA reduces the number of pods.

Example:

- app goes from 3 replicas to 0 replicas
### Second layer: Karpenter

- Now that fewer pods exist, some nodes may no longer be needed.

Karpenter then:

- removes empty nodes
- consolidates underused nodes
- reduces infrastructure spend

### Combined cost effect
### KEDA

- removes unnecessary app-level runtime

### Karpenter

- removes unnecessary cluster-level runtime

### Together:

- fewer idle apps
- fewer idle nodes
- lower non-production waste
# 17. Correct Creation Order
### KEDA order
- install KEDA
- verify KEDA is running
- deploy application
- create ScaledObject
- observe scaling behavior
### Karpenter order
- install Karpenter
- configure cloud permissions
- create EC2NodeClass
- create NodePool
- deploy workloads
- observe provisioning and consolidation

This order is very important.
> The custom objects are not the installation itself.
> They are the policy/configuration resources used after the controller exists.

# 18. Where They Are Usually Used

A common cost-optimized architecture uses them like this:

### Dev cluster
- KEDA installed
- Karpenter installed
- strongest cost controls
- bursty and idle workloads are common
### Stage cluster
- sometimes Karpenter
- sometimes selective KEDA
- more conservative behavior
- closer to production realism
### Production
- more conservative
- stability first
- cost optimization still possible, but carefully applied
# 19. Common Mistakes
## 19.1 KEDA mistakes
- installing KEDA and expecting it to work without ScaledObject
- using scale-to-zero for workloads that should stay warm
- assuming KEDA scales nodes
- choosing an unsuitable trigger
### Important reminder

- KEDA scales workloads, not nodes.

## 19.2 Karpenter mistakes
- installing Karpenter without cloud permissions
- creating NodePool without valid infrastructure definition
- overly broad or overly narrow node constraints
- using consolidation without understanding workload disruption
### Important reminder

- Karpenter scales nodes, not application replicas.

# 20. Very Plain Explanation
### KEDA

“Scale the app.”

`ScaledObject`

“Scale this app based on this signal.”

### Karpenter

“Scale the cluster nodes.”

`EC2NodeClass`

- “When creating AWS nodes, use these infrastructure settings.”

`NodePool`

- “Create and manage nodes with these rules, and remove or consolidate them when appropriate.”

# 21. Final Summary

KEDA and Karpenter are different but complementary.

### KEDA
- installed once per cluster
- used to scale apps
- configured with objects like ScaledObject
- reduces idle pod cost
### Karpenter
- installed once per cluster
- used to scale node capacity
- configured with objects like EC2NodeClass and NodePool
- reduces idle node cost
### Best way to remember them
- KEDA optimizes workload demand
- Karpenter optimizes infrastructure supply

That is why they work so well together in cost-optimized Kubernetes designs, especially in non-production environments.