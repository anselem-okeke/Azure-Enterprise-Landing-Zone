#!/bin/bash

touch terraform/providers.tf
touch terraform/versions.tf
touch terraform/README.md

touch terraform/envs/dev/main.tf
touch terraform/envs/dev/variables.tf
touch terraform/envs/dev/outputs.tf
touch terraform/envs/dev/terraform.tfvars.example
touch terraform/envs/dev/README.md

touch terraform/modules/resource-group/main.tf
touch terraform/modules/resource-group/variables.tf
touch terraform/modules/resource-group/outputs.tf

touch terraform/modules/network/main.tf
touch terraform/modules/network/variables.tf
touch terraform/modules/network/outputs.tf

touch terraform/modules/vnet-peering/main.tf
touch terraform/modules/vnet-peering/variables.tf
touch terraform/modules/vnet-peering/outputs.tf

touch terraform/modules/linux-vm/main.tf
touch terraform/modules/linux-vm/variables.tf
touch terraform/modules/linux-vm/outputs.tf

touch terraform/modules/private-service-example/main.tf
touch terraform/modules/private-service-example/variables.tf
touch terraform/modules/private-service-example/outputs.tf
