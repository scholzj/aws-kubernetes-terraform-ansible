
#########################
# Jump host instance
#########################

resource "aws_launch_configuration" "jumphost" {
    name_prefix = "${var.vpc_name}-jumphost-"
    image_id = "${var.default_ami}"
    instance_type = "${var.instance_types["jumphost"]}"

    associate_public_ip_address = true

    iam_instance_profile = "${aws_iam_instance_profile.jumphost.id}"

    key_name = "${var.default_keypair_name}"
    security_groups = ["${aws_security_group.jumpnet.id}"]

    user_data = "${data.template_file.jumphost-bootstrap-script.rendered}"

    lifecycle {
      create_before_destroy = true
    }

    depends_on = [
        "aws_s3_bucket_object.bootstrap-object"
    ]
}

resource "aws_autoscaling_group" "jumphost" {
  vpc_zone_identifier = [ "${aws_subnet.jumpnet.id}" ]
  name = "${var.vpc_name}-jumphost-asg"
  max_size = 1
  min_size = 1
  health_check_grace_period = 300
  health_check_type = "EC2"
  desired_capacity = 1
  force_delete = false
  launch_configuration = "${aws_launch_configuration.jumphost.name}"

  tag = [{
        key = "Name"
        value = "${var.vpc_name}-jumphost"
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
        value = "jumphost"
        propagate_at_launch = true
      }, {
        key = "ansibleNodeName"
        value = "jumphost"
        propagate_at_launch = true
      }
  ]
}
