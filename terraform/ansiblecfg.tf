#########
## Generate ansible.cfg
####################

# Generate ../ansible/ansible.cfg

data "template_file" "ansible_cfg" {
    template = "${file("${path.module}/template/ansible.cfg.tpl")}"
    vars {
      user = "${var.default_instance_user}"
      ssh_cfg_path = "../ansible/ssh.cfg"
    }
}

resource "null_resource" "ansible_cfg" {
  triggers {
    template_rendered = "${ data.template_file.ansible_cfg.rendered }"
  }

  provisioner "local-exec" {
    command = "echo '${ data.template_file.ansible_cfg.rendered }' > ../ansible/ansible.cfg"
  }
}
