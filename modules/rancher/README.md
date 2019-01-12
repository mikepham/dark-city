# Module: rancher
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_key | Rancher Access Key | string | n/a | yes |
| ami\_image |  | string | n/a | yes |
| availability\_zones |  | list | n/a | yes |
| capacity |  | string | n/a | yes |
| capacity\_max |  | string | n/a | yes |
| capacity\_min |  | string | n/a | yes |
| certificate\_arn | Certificate ARN | string | n/a | yes |
| cluster\_member\_size | Rancher Cluster member Size | string | n/a | yes |
| cluster\_name |  | string | n/a | yes |
| cluster\_size | Rancher Cluster Size | string | n/a | yes |
| drone\_admin\_accounts | Drone Admin Accounts | list | n/a | yes |
| drone\_database\_disk\_size | Drone Database Disk Size | string | n/a | yes |
| drone\_database\_instance\_type | Drone Database Instance Type | string | n/a | yes |
| drone\_database\_name | Drone Database Name | string | n/a | yes |
| drone\_database\_parameter\_group | Drone Database Parameter Group | string | n/a | yes |
| drone\_database\_password | Drone Database Password | string | n/a | yes |
| drone\_database\_type | Drone Database Type | string | n/a | yes |
| drone\_database\_type\_version | Drone Database Type Version | string | n/a | yes |
| drone\_database\_username | Drone Database UserName | string | n/a | yes |
| drone\_enabled | Enable Drone Module | string | n/a | yes |
| drone\_github\_client | Drone GitHub Client | string | n/a | yes |
| drone\_github\_organizations | Drone GitHub Organizations | list | n/a | yes |
| drone\_github\_secret | Drone GitHub Secret | string | n/a | yes |
| drone\_image\_tag | Drone Image Tag | string | n/a | yes |
| drone\_shared\_secret | Drone Shared Secret | string | n/a | yes |
| elasticsearch\_dedicated\_master\_count | Number of Dedicated Master Nodes | string | n/a | yes |
| elasticsearch\_dedicated\_master\_enabled | Enable Dedicated Master Node | string | n/a | yes |
| elasticsearch\_dedicated\_master\_type | Master Node Instance Type | string | n/a | yes |
| elasticsearch\_instance\_count | Number of ElasticSearch Instances | string | n/a | yes |
| elasticsearch\_instance\_type | ElasticSearch Instance Type | string | n/a | yes |
| elasticsearch\_node2node\_encryption | Enable Node-to-Node Encryption | string | n/a | yes |
| elasticsearch\_snapshot\_start\_hour | When to start the snapshot | string | n/a | yes |
| elasticsearch\_subnets | ElasticSearch Subnets | list | n/a | yes |
| elasticsearch\_version | ElasticSearch Version | string | n/a | yes |
| elasticsearch\_zone\_awareness\_enabled | Enable AWS Zone Awareness | string | n/a | yes |
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

