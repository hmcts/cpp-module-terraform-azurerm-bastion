# terraform-module-template

<!-- TODO fill in resource name in link to product documentation -->
Terraform module for private only Azure Bastion.


Why was this built using az_api?

```
There is a bug at the moment in Azure provider that means we can't use native terraform option for bastion_host with a private-only deployment, see this: https://github.com/hashicorp/terraform-provider-azurerm/issues/28220#issuecomment-2746040052 at least this is how it comes across.

Azure verified module we can piggyback from: https://registry.terraform.io/modules/Azure/avm-res-network-bastionhost/azurerm/latest which is open source registry.terraform.io/modules/Azure/avm-res-network-bastionhost/azurerm/latest for us to take the bits we need based on our typical setup - and means we get control over changes.

There is a module here; https://github.com/hmcts/terraform-module-azure-bastion/blob/main/azure-bastion.tf but it's hardcoded to require a public IP, and given the issue above with lack of support for private only deployment via terraform we should create similar like the AVM version.
```



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.13.3 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 2.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.10 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | ~> 2.4 |

## Resources

| Name | Type |
|------|------|
| [azapi_resource.bastion](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_copy_paste_enabled"></a> [copy\_paste\_enabled](#input\_copy\_paste\_enabled) | n/a | `string` | n/a | yes |
| <a name="input_file_copy_enabled"></a> [file\_copy\_enabled](#input\_file\_copy\_enabled) | n/a | `string` | n/a | yes |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | n/a | `map(any)` | n/a | yes |
| <a name="input_ip_connect_enabled"></a> [ip\_connect\_enabled](#input\_ip\_connect\_enabled) | n/a | `string` | n/a | yes |
| <a name="input_kerberos_enabled"></a> [kerberos\_enabled](#input\_kerberos\_enabled) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | n/a | `string` | n/a | yes |
| <a name="input_private_only_enabled"></a> [private\_only\_enabled](#input\_private\_only\_enabled) | Enable private-only Bastion (default: true) | `bool` | `true` | no |
| <a name="input_session_recording_enabled"></a> [session\_recording\_enabled](#input\_session\_recording\_enabled) | n/a | `string` | n/a | yes |
| <a name="input_shareable_link_enabled"></a> [shareable\_link\_enabled](#input\_shareable\_link\_enabled) | n/a | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | n/a | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_tunneling_enabled"></a> [tunneling\_enabled](#input\_tunneling\_enabled) | n/a | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | The availability zones where the Azure Bastion Host is deployed. | `set(string)` | <pre>[<br/>  "1",<br/>  "2",<br/>  "3"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The DNS name of the Bastion Host. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Bastion Host. |
| <a name="output_ip_configurations"></a> [ip\_configurations](#output\_ip\_configurations) | The IP configurations of the Bastion Host. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Bastion Host. |
<!-- END_TF_DOCS -->

## Contributing

We use pre-commit hooks for validating the terraform format and maintaining the documentation automatically.
Install it with:

```shell
$ brew install pre-commit terraform-docs
$ pre-commit install
```

If you add a new hook make sure to run it against all files:
```shell
$ pre-commit run --all-files
```
