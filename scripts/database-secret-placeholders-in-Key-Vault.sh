#!/bin/bash

az keyvault secret set \
  --vault-name kvanselemdevwe01 \
  --name db-host \
  --value "postgres-dev.internal"

az keyvault secret set \
  --vault-name kvanselemdevwe01 \
  --name db-name \
  --value "appdb"

az keyvault secret set \
  --vault-name kvanselemdevwe01 \
  --name db-username \
  --value "appuser"

az keyvault secret set \
  --vault-name kvanselemdevwe01 \
  --name db-password \
  --value "ChangeMe-Strong-Placeholder-Only"

az keyvault secret set \
  --vault-name kvanselemdevwe01 \
  --name db-connection-string \
  --value "Host=postgres-dev.internal;Database=appdb;Username=appuser;Password=ChangeMe-Strong-Placeholder-Only"
