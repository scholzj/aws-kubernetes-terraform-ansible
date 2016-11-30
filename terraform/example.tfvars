region = "eu-central-1"
zone = "eu-central-1b"

default_keypair_name = "MyKeyPair"
ssh_private_key_path = "../ansible/id_aws"

ssh_access_cidr = [
    "0.0.0.0/0"
]

api_access_cidr = [
    "0.0.0.0/0"
]

vpc_name = "my-k8s"
elb_name = "my-k8s-kubernetes-api"

vpc_cidr = "10.0.0.0/16"
vpc_public_subnet_cidr = "10.0.0.0/24"
vpc_private_subnet_cidr = "10.0.1.0/24"
kubernetes_service_cluster_cidr = "10.0.2.0/24"
kubernetes_pod_cidr = "10.0.32.0/19"
kubernetes_cluster_api = "10.0.2.1"
kubernetes_cluster_dns = "10.0.2.10"

default_ami = "ami-8504fdea"
default_instance_user = "ubuntu"

instance_types = {
  etcd = "t2.small"
  controller = "t2.small"
  worker = "t2.small"
  jumphost = "t2.micro"
}

## Tags
ansibleFilter = "my-k8s"
custom_tags = {
  Application = "MyApp"
  Confidentiality = "None"
  CostCenter = "000000"
  Owner = "user"
}

## Passwords - CHANGE THEM!!!
admin_password = "Chang3m3"
scheduler_password = "Chang3m3"
kubelet_password = "Chang3m3"
