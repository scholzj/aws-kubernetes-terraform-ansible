#!/bin/bash

apt-get update && apt-get -y install python-pip awscli unzip
pip install ansible
mkdir /var/lib/bootstrap
aws s3 cp s3://${s3_bucket}/${s3_object} /var/lib/bootstrap/bootstrap.zip --region ${region}
unzip /var/lib/bootstrap/bootstrap.zip -d /var/lib/bootstrap/
chmod +x /var/lib/bootstrap/hosts/ec2.py
/usr/local/bin/ansible-playbook /var/lib/bootstrap/bootstrap_controller.yaml
