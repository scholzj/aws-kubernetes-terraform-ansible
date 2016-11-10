####################
## Generate ssh.cfg
####################

# Generate ../ssh.cfg

data "template_file" "ssh_cfg" {
    template = "${file("${path.module}/template/ssh.cfg")}"
    depends_on = ["aws_instance.etcd", "aws_instance.controller", "aws_instance.worker"]
    vars {
      user = "${var.default_instance_user}"

      ssh_private_key_path = "${var.ssh_private_key_path}"

      jumphost_public_ip = "${aws_instance.jump.public_ip}"

      jumphost_ip = "${aws_instance.jump.private_ip}"
      etcd0_ip = "${aws_instance.etcd.0.private_ip}"
      etcd1_ip = "${aws_instance.etcd.1.private_ip}"
      etcd2_ip = "${aws_instance.etcd.2.private_ip}"
      controller0_ip = "${aws_instance.controller.0.private_ip}"
      controller1_ip = "${aws_instance.controller.1.private_ip}"
      controller2_ip = "${aws_instance.controller.2.private_ip}"
      worker0_ip = "${aws_instance.worker.0.private_ip}"
      worker1_ip = "${aws_instance.worker.1.private_ip}"
      worker2_ip = "${aws_instance.worker.2.private_ip}"
    }
}

resource "null_resource" "ssh_cfg" {
  triggers {
    template_rendered = "${ data.template_file.ssh_cfg.rendered }"
  }

  provisioner "local-exec" {
    command = "echo '${ data.template_file.ssh_cfg.rendered }' > ../ssh.cfg"
  }
}
