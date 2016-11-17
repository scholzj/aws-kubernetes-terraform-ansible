###############################
## Generate ec2.ini
####################

# Generate ../ansible/hosts/ec2.ini

data "template_file" "ec2_ini" {
    template = "${file("${path.module}/template/ec2.ini")}"
    depends_on = ["aws_instance.etcd", "aws_instance.controller", "aws_instance.worker"]
    vars {
      ansibleFilter = "${var.ansibleFilter}"
      regions = "${var.region}"

      vpc_cidr = "${var.vpc_cidr}"
      service_cidr = "${var.kubernetes_service_cluster_cidr}"
      pod_cidr = "${var.kubernetes_pod_cidr}"
      cluster_dns = "${var.kubernetes_cluster_dns}"
      api_endpoint = "${aws_elb.kubernetes_api.dns_name}"
    }
}

resource "null_resource" "ec2_ini" {
  triggers {
    template_rendered = "${ data.template_file.ec2_ini.rendered }"
  }

  provisioner "local-exec" {
    command = "echo '${ data.template_file.ec2_ini.rendered }' > ../ansible/hosts/ec2.ini"
  }
}
