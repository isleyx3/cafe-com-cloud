# Code Terraform

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.66.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.66.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster | n/a |
| <a name="module_subnet-network"></a> [subnet-network](#module\_subnet-network) | terraform-google-modules/network/google//modules/subnets | n/a |
| <a name="module_vpc-network"></a> [vpc-network](#module\_vpc-network) | terraform-google-modules/network/google//modules/vpc | 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/4.66.0/docs/resources/compute_router) | resource |
| [google_compute_router_nat.nat](https://registry.terraform.io/providers/hashicorp/google/4.66.0/docs/resources/compute_router_nat) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/4.66.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_activate_apis"></a> [activate\_apis](#input\_activate\_apis) | Service APIs to enable. | `list(string)` | <pre>[<br>  "compute.googleapis.com",<br>  "dns.googleapis.com",<br>  "container.googleapis.com"<br>]</pre> | no |
| <a name="input_owners"></a> [owners](#input\_owners) | Optional list of IAM-format members to set as project owners. | `list(string)` | `[]` | no |
