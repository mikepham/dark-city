# Environment: rancher
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| drone\_admin\_accounts | Drone Admin Account | list | n/a | yes |
| drone\_database\_disk\_size | Drone Database Disk Size | string | `"10"` | no |
| drone\_database\_instance\_type | Drone Database Instance Type | string | n/a | yes |
| drone\_database\_name | Drone Database Name | string | `"drone"` | no |
| drone\_database\_parameter\_group | Drone Database Parameter Group | string | `"default.mysql5.7"` | no |
| drone\_database\_type | Database Type | string | `"mysql"` | no |
| drone\_database\_type\_version | Drone Database Type Version | string | `"5.7"` | no |
| drone\_database\_username | Drone Database UserName | string | `"drone"` | no |
| drone\_enabled | Enables Drone Deployment | string | n/a | yes |
| drone\_github\_organizations | Drone GitHub Organizations | list | n/a | yes |
| drone\_image\_tag | Drone Image Docker Tag | string | `"0.8-alpine"` | no |
| elasticsearch\_dedicated\_master\_count | Number of Dedicated Master Nodes | string | n/a | yes |
| elasticsearch\_dedicated\_master\_enabled | Enable Dedicated Master Node | string | n/a | yes |
| elasticsearch\_dedicated\_master\_type | Master Node Instance Type | string | n/a | yes |
| elasticsearch\_enabled | Enable ElasticSearch | string | n/a | yes |
| elasticsearch\_encrypt\_at\_rest | Encrypt at Rest | string | n/a | yes |
| elasticsearch\_instance\_count | Number of ElasticSearch Instances | string | n/a | yes |
| elasticsearch\_instance\_type | ElasticSearch Instance Type | string | n/a | yes |
| elasticsearch\_node2node\_encryption | Enable Node-to-Node Encryption | string | n/a | yes |
| elasticsearch\_snapshot\_start\_hour | When to start the snapshot | string | `"23"` | no |
| elasticsearch\_version | ElasticSearch Version | string | n/a | yes |
| elasticsearch\_volume\_size | ElasticSearch Volume Size | string | n/a | yes |
| elasticsearch\_volume\_type | ElasticSearch Volume Type | string | n/a | yes |
| elasticsearch\_zone\_awareness\_enabled | Enable AWS Zone Awareness | string | n/a | yes |
| rancher\_ami\_image | Rancher AMI Image ID | string | n/a | yes |
| rancher\_availability\_zones | AWS Availibility Zones | list | n/a | yes |
| rancher\_capacity | AutoScaling Capacity | string | `"3"` | no |
| rancher\_capacity\_max | AutoScaling Capacity Max | string | `"5"` | no |
| rancher\_capacity\_min | AutoScaling Capacity Min | string | `"3"` | no |
| rancher\_certificate\_domain | Rancher Certificate Domain | string | n/a | yes |
| rancher\_cluster\_member\_size | Cluster member Size | string | `"3"` | no |
| rancher\_cluster\_size | Instance Count | string | `"1"` | no |
| rancher\_enable\_remote\_volumes | Enable Remote Volumes | string | n/a | yes |
| rancher\_enable\_services | Enable Additional Rancher Services | string | n/a | yes |
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

