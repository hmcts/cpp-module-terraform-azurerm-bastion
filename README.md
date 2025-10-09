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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.19.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | Application to which the s3 bucket relates | `string` | `""` | no |
| <a name="input_attribute"></a> [attribute](#input\_attribute) | An attribute of the s3 bucket that makes it unique | `string` | `""` | no |
| <a name="input_costcode"></a> [costcode](#input\_costcode) | Name of theDWP PRJ number (obtained from the project portfolio in TechNow) | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment into which resource is deployed | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"uksouth"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be an organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `""` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Name of the project or sqaud within the PDU which manages the resource. May be a persons name or email also | `string` | `""` | no |
| <a name="input_type"></a> [type](#input\_type) | Name of service type | `string` | `""` | no |
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
