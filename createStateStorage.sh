#!/bin/bash

set -eu

if !(type az > /dev/null 2>&1); then
  echo "should install azure-cli."
  exit
fi

LOCATION=japaneast
RESOURCE_GROUP_NAME=terraform-state-manager-rg
STORAGE_ACCOUNT_NAME=terraformstatemng
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location ${LOCATION}

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

