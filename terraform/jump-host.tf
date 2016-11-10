
#########################
# Jump host instance
#########################

resource "aws_instance" "jump" {
    ami = "${var.default_ami}"
    instance_type = "${var.jumphost_instance_type}"

    subnet_id = "${aws_subnet.jumpnet.id}"
    private_ip = "${cidrhost(var.vpc_public_subnet_cidr, 10)}"
    associate_public_ip_address = true # Instances have public, dynamic IP

    availability_zone = "${var.zone}"
    vpc_security_group_ids = ["${aws_security_group.jumpnet.id}"]
    key_name = "${var.default_keypair_name}"

    tags {
      Name = "dave-k8s-jumphost-0"
      Owner = "${var.owner}"
      Application = "${var.application}"
      Confidentiality = "${var.confidentality}"
      Costcenter = "${var.costcenter}"
      ansibleFilter = "${var.ansibleFilter}"
      ansibleNodeType = "jumphost"
      ansibleNodeName = "jumphost0"
    }
}

############
## Outputs
############

output "jumphost_dns_name" {
  value = "${aws_instance.jump.public_dns}"
}

output "jumphost_ip_address" {
  value = "${aws_instance.jump.public_ip}"
}
