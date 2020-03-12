# Sample: Configure Proxy in Azure VM Images

This is a sample how to configure corporate proxy settings in an azure VM image. 
[Packer](https://packer.io) and [Ansible](https://ansible.com) are used to automate the VM image creation.

## Prerequisites 

On your local machine or on your build agent, you need to install the following tools:

* [Packer](https://www.packer.io/docs/install/index.html)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [Azure CLI (az)](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

For a quick setup, you can use the [Azure Shell](https://shell.azure.com). All tools are pre-installed there.

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

To modify the behavior of the Ansible Proxy configuration process, you can add a second var-file or insert the following config in your env.json:

```json
{
    "proxy_protocol": "http",
    "proxy_host": "serverproxy.contoso.net",
    "proxy_port": "8080",
    "no_proxy": "169.254.169.254,168.63.129.16,localhost,127.0.0.1"
}
```

And finally, if you need to provision everything in a **private VNet without public IP address**, you have to add the following config:

```json
{
    "vnet_name": "TBD",
    "vnet_subnet_name": "TBD",
    "vnet_rg_name": "TBD"
}
```

and call packer with the `packer_private_vnet.json` template (see section **Run**).

## Variables

Besides passing the base config for Azure authentication, you can also modify the packer invocation with additional variables, see `./packer.json`'s variable section.

## Run

Invoke packer and building the image:
```bash
packer build -var-file=./env.json packer.json
```

For **private VNet**:
```bash
packer build -var-file=./env.json packer_private_vnet.json
```

Please note, that the target resource group for the packer images needs to exist. With the default variable configuration in `packer.json`, you can create the resource group via Azure CLI:

```
az group create -l westeurope -n vm_base_images_rg
```
