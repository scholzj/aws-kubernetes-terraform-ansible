# Outside access

variable control_cidr {
  description = "CIDR for maintenance: inbound traffic to the Jump host and to the Kubernetes API loadbalancer will be allowed from this IPs"
  type = "list"
  default = ["0.0.0.0/0"]
}

# Key

variable ssh_private_key_path {
  type = "string"
  default = "/home/user/.ssh/id_aws"
  description = "Path where the private key for SSH is stored"
}

variable default_keypair_name {
  default = "MyKeyPair"
  type = "string"
  description = "Name of the keypair which should be used for the hosts (Must already exist in AWS)"
}

# Tags

variable application {
  default = "MyApp"
  type = "string"
  description = "Application name (tag for AWS resources created via Terraform)"
}

variable confidentality {
  default = "None"
  type = "string"
  description = "Confidentiality flag (tag for AWS resources created via Terraform)"
}

variable costcenter {
  default = "000000"
  type = "string"
  description = "Const center (tag for AWS resources created via Terraform)"
}

variable owner {
  default = "user"
  type = "string"
  description = "Owner name (tag for AWS resources created via Terraform)"
}

variable ansibleFilter {
  description = "`ansibleFilter` tag value added to all instances, to enable instance filtering in Ansible dynamic inventory"
  default = "my-k8s" # IF YOU CHANGE THIS YOU HAVE TO CHANGE instance_filters = tag:ansibleFilter=Kubernetes01 in ./ansible/hosts/ec2.ini
  type = "string"
}

# Networking setup

variable region {
  default = "eu-central-1"
  type = "string"
  description = "AWS region which should be used"
}

variable zone {
  default = "eu-central-1b"
  type = "string"
  description = "AWS AZ (Availability zone) which should be used"
}

# VPC setup

variable vpc_name {
  description = "Name of the VPC"
  default = "my-k8s"
  type = "string"
}

variable elb_name {
  description = "Name of the ELB for Kubernetes API"
  default = "my-k8s-api"
  type = "string"
}

### VARIABLES BELOW MUST NOT BE CHANGED ###

variable vpc_cidr {
  default = "172.35.0.0/16"
  type = "string"
  description = ""
}

variable vpc_public_subnet_cidr {
  default = "172.35.0.0/24"
  type = "string"
  description = ""
}

variable vpc_private_subnet_cidr {
  default = "172.35.1.0/24"
  type = "string"
  description = ""
}

variable kubernetes_pod_cidr {
  default = "172.35.32.0/19"
  type = "string"
  description = ""
}

# Instances Setup

variable default_ami {
  description = "Default AMI for all nodes"
  default = "ami-8504fdea"
  type = "string"
}

variable default_instance_user {
  description = "User which should be used to connect to the hosts (Depends on the AMI)"
  default = "ubuntu"
  type = "string"
}

variable etcd_instance_type {
  default = "t2.small"
  type = "string"
  description = "Instance type for etcd hosts"
}

variable controller_instance_type {
  default = "t2.small"
  type = "string"
  description = "Instance type for controller hosts"
}

variable worker_instance_type {
  default = "t2.small"
  type = "string"
  description = "Instance type for worker hosts"
}

variable jumphost_instance_type {
  default = "t2.micro"
  type = "string"
  description = "Instance type for the jump host"
}

variable kubernetes_cluster_api {
  default = "172.35.2.1"
  type = "string"
  description = "Internal IP address of the Kubernetes API"
}

variable kubernetes_cluster_dns {
  default = "172.35.2.10"
  type = "string"
  description = "Internal IP address of kubernetes's own DNS server"
}
