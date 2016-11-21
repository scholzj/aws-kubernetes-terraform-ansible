region = "eu-central-1"
zone = "eu-central-1b"

default_keypair_name = "schojak"
ssh_private_key_path = "../schojak.pem"

ssh_access_cidr = [
    "88.208.76.87/32",
    "193.29.76.160/32",
    "193.29.76.161/32",
    "193.29.76.162/32",
    "193.29.76.163/32",
    "193.29.76.164/32",
    "193.29.76.165/32",
    "193.29.76.166/32",
    "193.29.76.167/32",
    "88.75.59.177/32"
]

api_access_cidr = [
    "0.0.0.0/0"
]

vpc_name = "dave-demo"
elb_name = "dave-demo-kubernetes-api"

vpc_cidr = "172.34.0.0/16"
vpc_public_subnet_cidr = "172.34.0.0/24"
vpc_private_subnet_cidr = "172.34.1.0/24"
kubernetes_service_cluster_cidr = "172.34.2.0/24"
kubernetes_pod_cidr = "172.34.32.0/19"
kubernetes_cluster_api = "172.34.2.1"
kubernetes_cluster_dns = "172.34.2.10"

default_ami = "ami-8504fdea"
default_instance_user = "ubuntu"

instance_types = {
  etcd = "t2.small"
  controller = "t2.small"
  worker = "t2.small"
  jumphost = "t2.nano"
}

## Tags
ansibleFilter = "dave-demo"
custom_tags = {
  Application = "DAVe"
  Confidentiality = "None"
  CostCenter = "000000"
  Owner = "schojak"
}

## Passwords - CHANGE THEM!!!
admin_password = "Chang3m3"
scheduler_password = "Chang3m3"
kubelet_password = "Chang3m3"
