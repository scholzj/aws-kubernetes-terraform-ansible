# Key

variable ssh_private_key_path {
  type = "string"
  description = "Path where the private key for SSH is stored"
}

variable default_keypair_name {
  type = "string"
  description = "Name of the keypair which should be used for the hosts (Must already exist in AWS)"
}

# Tags

variable custom_tags {
    description = "Different tag values which should be assigned to AWS resources created via Terraform)"
    type = "map"
}

variable ansibleFilter {
  description = "`ansibleFilter` tag value added to all instances, to enable instance filtering in Ansible dynamic inventory"
  type = "string"
}

# AWS Regions / Zones

variable region {
  type = "string"
  description = "AWS region which should be used"
}

variable zone {
  type = "string"
  description = "AWS AZ (Availability zone) which should be used"
}

# Resource naming

variable vpc_name {
  description = "Name of the VPC"
  type = "string"
}

variable elb_name {
  description = "Name of the ELB for Kubernetes API"
  type = "string"
}

# Network details (Change this only if you know what you are doing or if you think you are lucky)

variable vpc_cidr {
  type = "string"
  description = ""
}

variable vpc_public_subnet_cidr {
  type = "string"
  description = ""
}

variable vpc_private_subnet_cidr {
  type = "string"
  description = ""
}

variable kubernetes_service_cluster_cidr {
  type = "string"
  description = ""
}

variable kubernetes_pod_cidr {
  type = "string"
  description = ""
}

variable kubernetes_cluster_api {
  type = "string"
  description = "Internal IP address of the Kubernetes API"
}

variable kubernetes_cluster_dns {
  type = "string"
  description = "Internal IP address of kubernetes's own DNS server"
}

# Outside access

variable ssh_access_cidr {
  description = "CIDR for maintenance: inbound traffic to the Jump host using SSH and other protocols for management"
  type = "list"
}

variable api_access_cidr {
  description = "CIDR for maintenance: inbound traffic to the Kubernetes API loadbalancer will be allowed from this IPs"
  type = "list"
}

# Instances Setup

variable default_ami {
  description = "Default AMI for all nodes"
  type = "string"
}

variable default_instance_user {
  description = "User which should be used to connect to the hosts (Depends on the AMI)"
  type = "string"
}

variable instance_types {
    type = "map"
    description = "List of instance types to be used for different hosts"
}

# Passwords
variable admin_password {
  description = "Password for the admin user"
  type = "string"
}

variable kubelet_password {
  description = "Password for the admin user"
  type = "string"
}

variable scheduler_password {
  description = "Password for the admin user"
  type = "string"
}
