#
## Environment: development
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| rancher\_ami\_image | Rancher AMI Image ID | string | n/a | yes |
| rancher\_availability\_zones | AWS Availibility Zones | list | n/a | yes |
| rancher\_capacity | AutoScaling Capacity | string | `"3"` | no |
| rancher\_capacity\_max | AutoScaling Capacity Max | string | `"5"` | no |
| rancher\_capacity\_min | AutoScaling Capacity Min | string | `"3"` | no |
| rancher\_certificate\_domain | Rancher Certificate Domain | string | n/a | yes |
| rancher\_cluster\_member\_size | Cluster member Size | string | `"3"` | no |
| rancher\_cluster\_size | Instance Count | string | `"1"` | no |
| rancher\_environment | Environment Name | string | n/a | yes |
| rancher\_environment\_domain | Rancher Environment Domain | string | n/a | yes |
| rancher\_etcd\_token | Rancher ETCD Cluster Token | string | `"etcd-token"` | no |
| rancher\_iam\_profile | AWS IAM Profile | string | `"EC2"` | no |
| rancher\_instance\_type | AWS Instance Type | string | n/a | yes |
| rancher\_keypair | Rancher AWS PEM Key Pair | string | n/a | yes |
| rancher\_monitoring | Rancher Enable AWS Monitoring | string | `"true"` | no |
| rancher\_ntp\_hosts | NTP Hosts | list | `<list>` | no |
| rancher\_subnets | Rancher AWS Subnets | list | n/a | yes |
| rancher\_url | Rancher URL | string | n/a | yes |
| rancher\_use\_public\_ip | Rancher Enable Public IP | string | `"true"` | no |
| rancher\_volume\_size | Rancher Volume Size | string | `"8"` | no |
| rancher\_vpc\_ids | Rancher VPC Networks | list | n/a | yes |

