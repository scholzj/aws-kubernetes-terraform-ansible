[defaults]
remote_user = ${user}
host_key_checking = False
inventory = ./hosts/
remote_tmp = /tmp

[ssh_connection]
ssh_args = -F ${ssh_cfg_path}
