#########################
# etcd cluster instances
#########################

resource "aws_instance" "etcd" {
    count = 3
    ami = "${var.default_ami}"
    instance_type = "${var.instance_types["etcd"]}"

    iam_instance_profile = "${aws_iam_instance_profile.kubernetes-etcd.id}"

    subnet_id = "${aws_subnet.kubernetes.id}"
    private_ip = "${cidrhost(var.vpc_private_subnet_cidr, 10 + count.index)}"
    associate_public_ip_address = false # Instances have public, dynamic IP

    availability_zone = "${var.zone}"
    vpc_security_group_ids = ["${aws_security_group.kubernetes.id}"]
    key_name = "${var.default_keypair_name}"

    tags {
      Name = "dave-k8s-etcd-${count.index}"
      Owner = "${var.custom_tags["Owner"]}"
      Application = "${var.custom_tags["Application"]}"
      Confidentiality = "${var.custom_tags["Confidentiality"]}"
      Costcenter = "${var.custom_tags["CostCenter"]}"
      ansibleFilter = "${var.ansibleFilter}"
      ansibleNodeType = "etcd"
      ansibleNodeName = "etcd${count.index}"
    }
}
