#########
## Generate ansible.cfg
####################

# Generate ../ansible/ansible.cfg

data "template_file" "vars_yml" {
    template = "${file("${path.module}/template/vars.yml")}"
    vars {
      user = "${var.default_instance_user}"
      ssh_cfg_path = "../ssh.cfg"
    }
}

resource "null_resource" "vars_yml" {
  triggers {
    template_rendered = "${ data.template_file.vars_yml.rendered }"
  }

  provisioner "local-exec" {
    command = "echo '${ data.template_file.vars_yml.rendered }' > ../ansible/group_vars/allvars.yml"
  }
}
