#!/bin/bash

WORK_DIR=/var/lib/bootstrap/ansible

add-apt-repository -y ppa:ansible/ansible && apt-get update && apt-get -y install ansible awscli unzip python-boto jq

rm -rf $WORK_DIR
mkdir -p $WORK_DIR
pushd $WORK_DIR
aws s3 cp s3://${s3_bucket}/${s3_object} ./bootstrap.zip --region ${region}
unzip ./bootstrap.zip -d ./
chmod +x ./hosts/ec2.py
chmod 0600 ${ssh_private_key}
/usr/bin/ansible-playbook --extra-vars this_host=$(curl -s http://169.254.169.254/latest/meta-data/instance-id) bootstrap_jumphost.yaml
popd
