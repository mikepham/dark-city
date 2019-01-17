# Modules
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| associate\_public\_ip\_address | Associate a public IP address | string | n/a | yes |
| instance\_type | AWS Instance Type | string | n/a | yes |
| max\_size | Maximum number of VMs to create | string | n/a | yes |
| min\_size | Minimum number of VMs to create | string | n/a | yes |
| name | Auto-Scaling Group name | string | n/a | yes |
| region | AWS Region | string | n/a | yes |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_size | Cluster size. Musst be a value divisible by 3, 5, or 7 for a quorum | string | n/a | yes |
| enable\_clustering | Enable Clustering | string | n/a | yes |
| enable\_etcd | Enables ETCD Configuration | string | n/a | yes |
| enable\_ntp | Enables the NTP service | string | n/a | yes |
| ntp\_host | NTP time server | string | `"time.nist.gov"` | no |
| reboot\_group | Group to assign reboots to in order to maintain quorum | string | n/a | yes |
| reboot\_strategy | Determines how updates are applied | string | n/a | yes |
| region | AWS Region to use for the late AMI | string | n/a | yes |
| release\_channel | CoreOS Release Channel | string | `"stable"` | no |
| swap\_size | Swap size | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ignition |  |
| latest\_hvm |  |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| domain | Zone record for domain | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| zone\_id | AWS Zone ID |

