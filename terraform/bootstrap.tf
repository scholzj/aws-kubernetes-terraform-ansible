#########
## Generate the bootstrap scripts
####################

data "template_file" "jumphost-bootstrap-script" {
    template = "${file("${path.module}/template/jumphost-boostrap.sh.tpl")}"
    vars {
      region = "${var.region}"
      s3_bucket = "${var.vpc_name}-bootstrap"
      s3_object = "bootstrap.zip"
    }
}
