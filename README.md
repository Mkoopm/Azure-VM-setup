# Azure-VM-setup

It can be challenging to properly setup a virtual machine (VM) in Azure to run large language model's (LLM)'s.
Not only is a relatively expensive VM needed, but also Cuda install should be taken care of amongst other things.
The aim of this repository is to simplify that process and avoid costly mistakes. 
It contains deployement and setup scripts for an Azure VM to run models on a GPU.
In the future it might come to include a clientless remote desktop as well. 

## Requirements

The Azure command-line interface is required to create the virtual machine. 

## Installation

1) run `vm-create.sh` to creat the VM.
2) clone this repository on the VM.
3) execute `vm-setup.sh` on the VM to install dependencies.