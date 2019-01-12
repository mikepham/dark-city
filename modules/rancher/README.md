# Module: rancher
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_key | Rancher Access Key | string | n/a | yes |
| ami\_image |  | string | n/a | yes |
| availability\_zones |  | list | n/a | yes |
| aws\_subnets | AWS Subnets | list | n/a | yes |
| capacity |  | string | n/a | yes |
| capacity\_max |  | string | n/a | yes |
| capacity\_min |  | string | n/a | yes |
| certificate\_arn | Certificate ARN | string | n/a | yes |
| cluster\_member\_size | Rancher Cluster member Size | string | n/a | yes |
| cluster\_name |  | string | n/a | yes |
| cluster\_size | Rancher Cluster Size | string | n/a | yes |
| environment\_domain | Environment Domain Name | string | n/a | yes |
| environment\_domain\_tld | Environment Domain TLD | string | n/a | yes |
| environment\_name | Rancher Environment | string | n/a | yes |
| environment\_rancher\_url | Rancher Environment Url | string | n/a | yes |
| etcd\_token | ETCD Cluster Token | string | n/a | yes |
| http\_port | HTTP Port | string | `"80"` | no |
| http\_protocol | HTTP Protocol | string | `"HTTP"` | no |
| iam\_profile | AWS IAM Profile | string | n/a | yes |
| instance\_type |  | string | n/a | yes |
| keypair | PEM Key Pair | string | n/a | yes |
| monitoring | Enable Monitoring | string | n/a | yes |
| ntp\_hosts | NTP hosts | list | n/a | yes |
| secret\_key | Rancher Secret Key | string | n/a | yes |
| ssl\_port | SSL Port | string | `"443"` | no |
| ssl\_protocol | SSL Protocol | string | `"HTTPS"` | no |
| subnets | Attached Subnets | list | n/a | yes |
| termination\_policies |  | list | `<list>` | no |
| use\_public\_ip | Enable Public IP | string | n/a | yes |
| volume\_size | Volume Size | string | n/a | yes |
| volume\_type | Volume Type | string | `"gp2"` | no |
| vpc\_ids | VPC Network IDs | list | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| rancher\_environment\_id | Rancher Environment ID |

