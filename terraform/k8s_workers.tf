
############################################
# K8s Worker (aka Nodes, Minions) Instances
############################################

resource "aws_instance" "worker" {
    count = 3
    ami = "${var.default_ami}"
    instance_type = "${var.instance_types["worker"]}"

    iam_instance_profile = "${aws_iam_instance_profile.kubernetes-worker.id}"

    subnet_id = "${aws_subnet.kubernetes.id}"
    private_ip = "${cidrhost(var.vpc_private_subnet_cidr, 30 + count.index)}"
    associate_public_ip_address = false # Instances have public, dynamic IP
    source_dest_check = false # TODO Required??

    availability_zone = "${var.zone}"
    vpc_security_group_ids = ["${aws_security_group.kubernetes.id}"]
    key_name = "${var.default_keypair_name}"

    root_block_device   {
        volume_size = 50
        volume_type = "gp2"
        delete_on_termination = true
    }

    tags {
      Name = "${var.vpc_name}-worker-${count.index}"
      Owner = "${var.custom_tags["Owner"]}"
      Application = "${var.custom_tags["Application"]}"
      Confidentiality = "${var.custom_tags["Confidentiality"]}"
      Costcenter = "${var.custom_tags["CostCenter"]}"
      ansibleFilter = "${var.ansibleFilter}"
      ansibleNodeType = "worker"
      ansibleNodeName = "worker${count.index}"
    }
}

output "kubernetes_workers_public_ip" {
  value = "${join(",", aws_instance.worker.*.public_ip)}"
}
