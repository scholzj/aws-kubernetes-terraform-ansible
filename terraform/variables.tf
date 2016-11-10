# Outside access

variable control_cidr {
  description = "CIDR for maintenance: inbound traffic will be allowed from this IPs"
  default = ["88.208.76.87/32", "193.29.76.166/32", "193.29.76.163/32", "193.29.76.164/32", "193.29.76.160/32"]
}

# Key

variable ssh_private_key_path {
  default = "../schojak.pem"
}

variable default_keypair_name {
  default = "schojak"
}

# Tags

variable application {
  default = "DAVe"
}

variable confidentality {
  default = "None"
}

variable costcenter {
  default = "000000"
}

variable owner {
  default = "schojak"
}

variable ansibleFilter {
  description = "`ansibleFilter` tag value added to all instances, to enable instance filtering in Ansible dynamic inventory"
  default = "dave-k8s" # IF YOU CHANGE THIS YOU HAVE TO CHANGE instance_filters = tag:ansibleFilter=Kubernetes01 in ./ansible/hosts/ec2.ini
}

# Networking setup

variable region {
  default = "eu-central-1"
}

variable zone {
  default = "eu-central-1b"
}

# VPC setup

variable vpc_name {
  description = "Name of the VPC"
  default = "dave-k8s"
}

variable elb_name {
  description = "Name of the ELB for Kubernetes API"
  default = "dave-k8s-api"
}

### VARIABLES BELOW MUST NOT BE CHANGED ###

variable vpc_cidr {
  default = "172.35.0.0/16"
}

variable vpc_public_subnet_cidr {
  default = "172.35.0.0/24"
}

variable vpc_private_subnet_cidr {
  default = "172.35.1.0/24"
}

variable kubernetes_pod_cidr {
  default = "172.35.32.0/19"
}

# Instances Setup

variable default_ami {
  description = "Default AMI for all nodes"
  default = "ami-8504fdea"
}

variable default_instance_user {
  default = "ubuntu"
}

variable etcd_instance_type {
  default = "t2.small"
}

variable controller_instance_type {
  default = "t2.small"
}

variable worker_instance_type {
  default = "t2.small"
}

variable jumphost_instance_type {
  default = "t2.micro"
}

variable kubernetes_cluster_api {
  default = "172.35.2.1"
}

variable kubernetes_cluster_dns {
  default = "172.35.2.10"
}
