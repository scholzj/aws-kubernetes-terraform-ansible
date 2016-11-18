Host ${jumphost_public_ip}
  IdentityFile ${ssh_private_key_path}
  User ${user}
  UserKnownHostsFile=/dev/null
  StrictHostKeyChecking=no

Host ${jumphost_ip}
  ProxyCommand ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p -i ${ssh_private_key_path} ${user}@${jumphost_public_ip}
  IdentityFile ${ssh_private_key_path}
  User ${user}
  UserKnownHostsFile=/dev/null
  StrictHostKeyChecking=no

Host ${etcd0_ip}
  ProxyCommand ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p -i ${ssh_private_key_path} ${user}@${jumphost_public_ip}
  IdentityFile ${ssh_private_key_path}
  User ${user}
  UserKnownHostsFile=/dev/null
  StrictHostKeyChecking=no

Host ${etcd1_ip}
  ProxyCommand ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p -i ${ssh_private_key_path} ${user}@${jumphost_public_ip}
  IdentityFile ${ssh_private_key_path}
  User ${user}
  UserKnownHostsFile=/dev/null
  StrictHostKeyChecking=no

Host ${etcd2_ip}
  ProxyCommand ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p -i ${ssh_private_key_path} ${user}@${jumphost_public_ip}
  IdentityFile ${ssh_private_key_path}
  User ${user}
  UserKnownHostsFile=/dev/null
  StrictHostKeyChecking=no

Host ${controller0_ip}
  ProxyCommand ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p -i ${ssh_private_key_path} ${user}@${jumphost_public_ip}
  IdentityFile ${ssh_private_key_path}
  User ${user}
  UserKnownHostsFile=/dev/null
  StrictHostKeyChecking=no

Host ${controller1_ip}
  ProxyCommand ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p -i ${ssh_private_key_path} ${user}@${jumphost_public_ip}
  IdentityFile ${ssh_private_key_path}
  User ${user}
  UserKnownHostsFile=/dev/null
  StrictHostKeyChecking=no

Host ${controller2_ip}
  ProxyCommand ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p -i ${ssh_private_key_path} ${user}@${jumphost_public_ip}
  IdentityFile ${ssh_private_key_path}
  User ${user}
  UserKnownHostsFile=/dev/null
  StrictHostKeyChecking=no

Host ${worker0_ip}
  ProxyCommand ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p -i ${ssh_private_key_path} ${user}@${jumphost_public_ip}
  IdentityFile ${ssh_private_key_path}
  User ${user}
  UserKnownHostsFile=/dev/null
  StrictHostKeyChecking=no

Host ${worker1_ip}
  ProxyCommand ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p -i ${ssh_private_key_path} ${user}@${jumphost_public_ip}
  IdentityFile ${ssh_private_key_path}
  User ${user}
  UserKnownHostsFile=/dev/null
  StrictHostKeyChecking=no

Host ${worker2_ip}
  ProxyCommand ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p -i ${ssh_private_key_path} ${user}@${jumphost_public_ip}
  IdentityFile ${ssh_private_key_path}
  User ${user}
  UserKnownHostsFile=/dev/null
  StrictHostKeyChecking=no
