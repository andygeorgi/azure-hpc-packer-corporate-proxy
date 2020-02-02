# Sample: Configure Proxy in Azure VM Images

This is a sample how to configure corporate proxy settings in an azure VM image. 
[Packer](https://packer.io) and [Ansible](https://ansible.com) are used to automate the VM image creation.

## Prerequisites 

On your local machine or on your build agent, you need to install the following tools:

* [Packer](https://www.packer.io/docs/install/index.html)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [Azure CLI (az)](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

## Ansible Config

Patch the Ansible `group_vars` config in `./ansible/group_vars/all` according to your proxy config:

```txt
proxy_protocol: http

proxy_host: serverproxy.contoso.net

proxy_port: 8080
```

## Packer Config

Packer requires access to an Azure Subscription to automate the creation of the VM image. There are [multiple ways to achieve that](https://www.packer.io/docs/builders/azure.html). In this example, the configuration of an Azure AD Service Principal is provided via Packer variables. This is most often the case for an end-to-end automation.

You can either provide a env.json file like this:
```json
{
    "client_id": "your_client_id",
    "client_secret": "your_client_secret",
    "subscription_id": "your_subscription_id",
    "tenant_id": "your_tenant_id"
}
```

... and pass the variables like this to Packer `-var-file=./env.json`.
Alternatively, you can pass all variables individually without a var-file.

## Variables

Besides passing the base config for Azure authentication, you can also modify the packer invocation with additional variables, see `./packer.json`'s variable section.

## Run

Invoke packer and building the image:
```
packer build -var-file=./env.json packer.json
```

Please note, that the target resource group for the packer images needs to exist. With the default variable configuration in `packer.json`, you can create the resource group via Azure CLI:

```
az group create -l westeurope -n vm_base_images_rg
```
