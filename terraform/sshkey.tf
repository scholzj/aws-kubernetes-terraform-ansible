##########
# Generating new SSH keypair
##########

resource "null_resource" "ssh_key" {
  provisioner "local-exec" {
    command = "ssh-keygen -t rsa -P '' -f ${var.ssh_private_key_path}"
  }
}

##########
# Keypair
##########

resource "aws_key_pair" "default_keypair" {
  key_name = "${var.default_keypair_name}"
  public_key = "${file(\"${var.ssh_private_key_path}.pub\")}"
}
