# AWS deployment

This directory contains the DAVe deployment into Kubernetes cluster running on Amazon AWS. The deployment is using Terraform to deploy the infrastructure andf Ansible to setup the Kubernetes on top of it. It is heavily inspired by https://opencredo.com/kubernetes-aws-terraform-ansible-1/.

## TODOs

See the project dashboard.

## Installation

* Create a copy of the `example.tfvars` file and change the variables according to your needs. Don't forget to change the passwords!
* Go to the `terraform` directory and run:
```
terraform apply --var-file=my-var-file.tfvars
```
* After Terraform completes, move to the `ansible` directory
* To install the Kubernetes components on the EC2 hosts, run:
```
ansible-playbook infra.yaml
```
* To activate the `kubectl` command line tool on your localhost and on the jumphost, run:
```
ansible-playbook kubectl.yaml
```
* Next, install the DNS server with:
```
ansible-playbook kubernetes-dns.yaml
```
* Install the Dashboard with:
```
ansible-playbook kubernetes-dashboard.yaml
```
* To enable automatic storage provisioning (needed by logging and monitoring in next steps), create the storage class:
```
ansible-playbook kubernetes-storage.yaml
```
* Install the network routing with:
```
ansible-playbook kubernetes-routing.yaml
```
* (optional) Install the Monitoring (Heapster, InfluxDB, Grafana) with:
```
ansible-playbook monitoring.yaml
```
* (optional) Install the Logging (ElasticSearch, Kibana) with:
```
ansible-playbook logging.yaml
```
