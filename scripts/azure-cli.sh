#!/bin/bash

az aks show \
  --resource-group rg-spoke-dev-network \
  --name aks-dev-we-01 \
  --output table

az aks get-credentials \
  --resource-group rg-spoke-dev-network \
  --name aks-dev-we-01 \
  --overwrite-existing

kubectl get nodes
kubectl get pods -A

az network private-endpoint show \
  --resource-group rg-spoke-dev-network \
  --name pep-kv-shared-dev-we-01 \
  --output table

az network private-endpoint show \
  --resource-group rg-spoke-dev-network \
  --name pep-kv-shared-dev-we-01 \
  --query "privateLinkServiceConnections" \
  --output json


az network private-dns link vnet list \
  --resource-group rg-shared-services-dev \
  --zone-name privatelink.vaultcore.azure.net \
  --output table


az network private-dns record-set a list \
  --resource-group rg-shared-services-dev \
  --zone-name privatelink.vaultcore.azure.net \
  --output table


terraform fmt -recursive
terraform validate
terraform plan -out=tfplan




