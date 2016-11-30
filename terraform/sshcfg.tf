####################
## Generate ssh.cfg
####################

# Generate ../ssh.cfg

data "template_file" "ssh_cfg" {
    template = "${file("${path.module}/template/ssh.cfg.tpl")}"
    vars {
      user = "${var.default_instance_user}"
      ssh_private_key_path = "${var.ssh_private_key_path}"
    }
}

resource "null_resource" "ssh_cfg" {
  triggers {
    template_rendered = "${ data.template_file.ssh_cfg.rendered }"
  }

  provisioner "local-exec" {
    command = "echo '${ data.template_file.ssh_cfg.rendered }' > ../ansible/ssh.cfg"
  }
}
