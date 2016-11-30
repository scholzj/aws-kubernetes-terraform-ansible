############################
# K8s Control Pane instances
############################

resource "aws_launch_configuration" "controller" {
    name_prefix = "${var.vpc_name}-controller-"
    image_id = "${var.default_ami}"
    instance_type = "${var.instance_types["controller"]}"

    associate_public_ip_address = true

    iam_instance_profile = "${aws_iam_instance_profile.controller.id}"

    key_name = "${var.default_keypair_name}"
    security_groups = ["${aws_security_group.kubernetes.id}"]

    user_data = "${data.template_file.controller-bootstrap-script.rendered}"

    lifecycle {
      create_before_destroy = true
    }

    depends_on = [
        "aws_s3_bucket_object.bootstrap-object"
    ]
}

resource "aws_autoscaling_group" "controller" {
  vpc_zone_identifier = [ "${aws_subnet.kubernetes.id}" ]
  name = "${var.vpc_name}-controller-asg"
  max_size = 3
  min_size = 3
  health_check_grace_period = 300
  health_check_type = "EC2"
  desired_capacity = 3
  force_delete = false
  launch_configuration = "${aws_launch_configuration.controller.name}"
  load_balancers = ["${aws_elb.kubernetes_api.id}"]

  tag = [{
        key = "Name"
        value = "${var.vpc_name}-controller"
        propagate_at_launch = true
      }, {
        key = "Owner"
        value = "${var.custom_tags["Owner"]}"
        propagate_at_launch = true
      }, {
        key = "Application"
        value = "${var.custom_tags["Application"]}"
        propagate_at_launch = true
      }, {
        key = "Confidentiality"
        value = "${var.custom_tags["Confidentiality"]}"
        propagate_at_launch = true
      }, {
        key = "Costcenter"
        value = "${var.custom_tags["CostCenter"]}"
        propagate_at_launch = true
      }, {
        key = "ansibleFilter"
        value = "${var.ansibleFilter}"
        propagate_at_launch = true
      }, {
        key = "ansibleNodeType"
        value = "controller"
        propagate_at_launch = true
      }, {
        key = "ansibleNodeName"
        value = "controller"
        propagate_at_launch = true
      }
  ]
}

###############################
## Kubernetes API Load Balancer
###############################

resource "aws_elb" "kubernetes_api" {
    name = "${var.elb_name}"
    #instances = ["${aws_instance.controller.*.id}"]
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

// resource "aws_security_group_rule" "api_allow_all_from_jump_host" {
//     type = "ingress"
//     from_port = 6443
//     to_port = 6443
//     protocol = "tcp"
//     cidr_blocks = ["${aws_instance.jump.public_ip}/32"]
//     security_group_id = "${aws_security_group.kubernetes_api.id}"
// }

############
## Outputs
############

output "kubernetes_api_dns_name" {
  value = "${aws_elb.kubernetes_api.dns_name}"
}
