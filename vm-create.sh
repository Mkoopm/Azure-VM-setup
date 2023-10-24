#!/bin/bash
set -e

source .config.env

# Set your variables
required_vars=(
    ACTIVE_AZURE_TENANT_ID
    MY_AZURE_SUBSCRIPTION_ID
    MY_EMAIL
    RESOURCE_GROUP_NAME 
    VM_NAME 
    VM_LOCATION
    IMAGE_SKU 
    VM_SIZE 
    OS_DISK_SIZE_GB 
    SSH_KEY_PATH 
    VM_SHUT_DOWN_TIME
    VM_OPEN_PORT
)

# Unset varables can be hard to debug, so check if they exist
for var in $required_vars; do
    if [[ -z ${!var} ]]; then
        echo "The variable \"$var\" is not set, exiting..."
        exit 1
    fi
done

# Only if we are not logged in we log in, this often saves us an authentication step
if ! az account show; then
    az login --tenant $ACTIVE_AZURE_TENANT_ID
    echo "Logged in succesfully."
fi

# Set your subscription
az account set --subscription $MY_AZURE_SUBSCRIPTION_ID

# Create a resource group
az group create --name $RESOURCE_GROUP_NAME --location $VM_LOCATION

# Create the VM with the desired OS disk size
az vm create --resource-group $RESOURCE_GROUP_NAME --name $VM_NAME --image $IMAGE_SKU --admin-username $USER --size $VM_SIZE --os-disk-size-gb $OS_DISK_SIZE_GB --ssh-key-values $SSH_KEY_PATH

# Set auto-shutdown to save cost
az vm auto-shutdown -g $RESOURCE_GROUP_NAME -n $VM_NAME --time $VM_SHUT_DOWN_TIME --email $MY_EMAIL

# Open port used for communication with the fastchat API
az vm open-port --resource-group $RESOURCE_GROUP_NAME --name $VM_NAME --port $VM_OPEN_PORT
