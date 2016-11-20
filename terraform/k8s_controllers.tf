############################
# K8s Control Pane instances
############################

resource "aws_instance" "controller" {
    count = 3
    ami = "${var.default_ami}"
    instance_type = "${var.instance_types["controller"]}"

    iam_instance_profile = "${aws_iam_instance_profile.kubernetes-controller.id}"

    subnet_id = "${aws_subnet.kubernetes.id}"
    private_ip = "${cidrhost(var.vpc_private_subnet_cidr, 20 + count.index)}"
    associate_public_ip_address = false # Instances have public, dynamic IP
    source_dest_check = false # TODO Required??

    availability_zone = "${var.zone}"
    vpc_security_group_ids = ["${aws_security_group.kubernetes.id}"]
    key_name = "${var.default_keypair_name}"

    tags {
      Name = "${var.vpc_name}-controller-${count.index}"
      Owner = "${var.custom_tags["Owner"]}"
      Application = "${var.custom_tags["Application"]}"
      Confidentiality = "${var.custom_tags["Confidentiality"]}"
      Costcenter = "${var.custom_tags["CostCenter"]}"
      ansibleFilter = "${var.ansibleFilter}"
      ansibleNodeType = "controller"
      ansibleNodeName = "controller${count.index}"
    }
}

###############################
## Kubernetes API Load Balancer
###############################

resource "aws_elb" "kubernetes_api" {
    name = "${var.elb_name}"
    instances = ["${aws_instance.controller.*.id}"]
    subnets = ["${aws_subnet.jumpnet.id}"]
    cross_zone_load_balancing = false

    security_groups = ["${aws_security_group.kubernetes_api.id}"]

    listener {
      lb_port = 6443
      instance_port = 6443
      lb_protocol = "TCP"
      instance_protocol = "TCP"
    }

    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 15
      target = "HTTP:8080/healthz"
      interval = 30
    }

    tags {
      Name = "${var.elb_name}"
      Owner = "${var.custom_tags["Owner"]}"
      Application = "${var.custom_tags["Application"]}"
      Confidentiality = "${var.custom_tags["Confidentiality"]}"
      Costcenter = "${var.custom_tags["CostCenter"]}"
    }
}

############
## Security
############

resource "aws_security_group" "kubernetes_api" {
  vpc_id = "${aws_vpc.kubernetes.id}"
  name = "${var.elb_name}"

  tags {
    Name = "${var.elb_name}"
    Owner = "${var.custom_tags["Owner"]}"
    Application = "${var.custom_tags["Application"]}"
    Confidentiality = "${var.custom_tags["Confidentiality"]}"
    Costcenter = "${var.custom_tags["CostCenter"]}"
  }
}

resource "aws_security_group_rule" "api_allow_all_outbound" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.kubernetes_api.id}"
}

resource "aws_security_group_rule" "api_allow_all_from_control_host" {
    count = "${length(var.api_access_cidr)}"
    type = "ingress"
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = ["${var.api_access_cidr[count.index]}"]
    security_group_id = "${aws_security_group.kubernetes_api.id}"
}

resource "aws_security_group_rule" "api_allow_all_from_jump_host" {
    type = "ingress"
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = ["${aws_instance.jump.public_ip}/32"]
    security_group_id = "${aws_security_group.kubernetes_api.id}"
}

############
## Outputs
############

output "kubernetes_api_dns_name" {
  value = "${aws_elb.kubernetes_api.dns_name}"
}
