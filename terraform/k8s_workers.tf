
############################################
# K8s Worker (aka Nodes, Minions) Instances
############################################

resource "aws_launch_configuration" "worker" {
    name_prefix = "${var.vpc_name}-worker-"
    image_id = "${var.default_ami}"
    instance_type = "${var.instance_types["worker"]}"

    associate_public_ip_address = false

    iam_instance_profile = "${aws_iam_instance_profile.worker.id}"

    key_name = "${var.default_keypair_name}"
    security_groups = ["${aws_security_group.kubernetes.id}"]

    user_data = "${data.template_file.worker-bootstrap-script.rendered}"

    root_block_device   {
        volume_size = 50
        volume_type = "gp2"
        delete_on_termination = true
    }

    lifecycle {
      create_before_destroy = true
    }

    depends_on = [
        "aws_s3_bucket_object.bootstrap-object"
    ]
}

resource "aws_autoscaling_group" "worker" {
  vpc_zone_identifier = [ "${aws_subnet.kubernetes.id}" ]
  name = "${var.vpc_name}-worker-asg"
  max_size = 3
  min_size = 3
  health_check_grace_period = 300
  health_check_type = "EC2"
  desired_capacity = 3
  force_delete = false
  launch_configuration = "${aws_launch_configuration.worker.name}"

  tag = [{
        key = "Name"
        value = "${var.vpc_name}-worker"
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
        value = "worker"
        propagate_at_launch = true
      }, {
        key = "ansibleNodeName"
        value = "worker"
        propagate_at_launch = true
      }
  ]
}
