###############################
## Generate vars.yml
####################

# Generate ../ansible/group_vars/all/vars.yml

data "template_file" "vars_yml" {
    template = "${file("${path.module}/template/vars.yml")}"
    vars {
      vpc_cidr = "${var.vpc_cidr}"
      service_cidr = "${var.kubernetes_service_cluster_cidr}"
      pod_cidr = "${var.kubernetes_pod_cidr}"
      cluster_dns = "${var.kubernetes_cluster_dns}"
      api_endpoint = "${aws_elb.kubernetes_api.dns_name}"
      cluster_name = "${var.vpc_name}"


      aws_region = "${var.region}"
      aws_zone = "${var.zone}"

      admin_password = "${var.admin_password}"
      scheduler_password = "${var.scheduler_password}"
      kubelet_password = "${var.kubelet_password}"
    }
}

resource "null_resource" "vars_yml" {
  triggers {
    template_rendered = "${ data.template_file.vars_yml.rendered }"
  }

  provisioner "local-exec" {
    command = "echo '${ data.template_file.vars_yml.rendered }' > ../ansible/group_vars/all/vars.yml"
  }
}
