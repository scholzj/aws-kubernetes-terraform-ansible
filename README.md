# AWS deployment

This directory contains the DAVe deployment into Kubernetes cluster running on Amazon AWS. The deployment is using Terraform to deploy the infrastructure andf Ansible to setup the Kubernetes on top of it. It is heavily inspired by https://opencredo.com/kubernetes-aws-terraform-ansible-1/.

## TODOs

* ~~Integrate with AWS cloud provider~~
* ~~Move into private network to make sure that hosts are not accessible directly from outside~~
* Move accross two zones to make it more HA
* See if resources created by k8s can be automatically tagged in sync with our own requirements
* See how persistent disk provisioning works
* Create a cleanup procedure which would clean k8s resources (currently, kubernetes don't clean some resources such as security groups etc. That blocks terraform from deleting the VPC)
* Bootstrap the hosts in cloud init, so that we can use auto-scale groups in amazon and not only from outside (might be complicated due to the fixed IP setup currently used)
* Add ssh certificate validation when connecting to the remote hosts using SSH (Ansible)
* Store Terraform state in S3
