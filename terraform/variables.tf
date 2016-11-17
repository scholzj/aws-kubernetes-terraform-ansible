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

variable custom_tags {
    description = "Different tag values which should be assigned to AWS resources created via Terraform)"
    type = "map"

    default = {
        Application = "MyApp"
        Confidentiality = "None"
        CostCenter = "000000"
        Owner = "user"
    }
}

variable ansibleFilter {
  description = "`ansibleFilter` tag value added to all instances, to enable instance filtering in Ansible dynamic inventory"
  default = "my-k8s" # IF YOU CHANGE THIS YOU HAVE TO CHANGE instance_filters = tag:ansibleFilter=Kubernetes01 in ./ansible/hosts/ec2.ini
  type = "string"
}

# AWS Regions / Zones

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

# Resource naming

variable vpc_name {
  description = "Name of the VPC"
  default = "my-k8s"
  type = "string"
}

variable elb_name {
  description = "Name of the ELB for Kubernetes API"
  default = "my-k8s-kubernetes-api"
  type = "string"
}

# Network details (Change this only if you know what you are doing or if you think you are lucky)

variable vpc_cidr {
  default = "10.0.0.0/16"
  type = "string"
  description = ""
}

variable vpc_public_subnet_cidr {
  default = "10.0.0.0/24"
  type = "string"
  description = ""
}

variable vpc_private_subnet_cidr {
  default = "10.0.1.0/24"
  type = "string"
  description = ""
}

variable kubernetes_service_cluster_cidr {
  default = "10.0.2.0/24"
  type = "string"
  description = ""
}

variable kubernetes_pod_cidr {
  default = "10.0.32.0/19"
  type = "string"
  description = ""
}

variable kubernetes_cluster_api {
  default = "10.0.2.1"
  type = "string"
  description = "Internal IP address of the Kubernetes API"
}

variable kubernetes_cluster_dns {
  default = "10.0.2.10"
  type = "string"
  description = "Internal IP address of kubernetes's own DNS server"
}

# Outside access

variable control_cidr {
  description = "CIDR for maintenance: inbound traffic to the Jump host and to the Kubernetes API loadbalancer will be allowed from this IPs"
  type = "list"
  default = ["0.0.0.0/0"]
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

variable instance_types {
    type = "map"
    description = "List of instance types to be used for different hosts"

    default = {
        etcd = "t2.small"
        controller = "t2.small"
        worker = "t2.small"
        jumphost = "t2.nano"
    }
}
