#!/bin/bash

az role assignment create \
  --assignee 39370b73-1fe2-4f3e-bf6a-a0f779b615fa \
  --role "Contributor" \
  --scope /subscriptions/fcf48efa-3888-4412-930c-99d8a7f9067c/resourceGroups/rg-hub-network-dev

az role assignment create \
  --assignee 39370b73-1fe2-4f3e-bf6a-a0f779b615fa \
  --role "Contributor" \
  --scope /subscriptions/fcf48efa-3888-4412-930c-99d8a7f9067c/resourceGroups/rg-spoke-dev-network

az role assignment create \
  --assignee 39370b73-1fe2-4f3e-bf6a-a0f779b615fa \
  --role "Contributor" \
  --scope /subscriptions/fcf48efa-3888-4412-930c-99d8a7f9067c/resourceGroups/rg-shared-services-dev

az role assignment create \
  --assignee 39370b73-1fe2-4f3e-bf6a-a0f779b615fa \
  --role "Contributor" \
  --scope /subscriptions/fcf48efa-3888-4412-930c-99d8a7f9067c/resourceGroups/rg-tfstate-dev
