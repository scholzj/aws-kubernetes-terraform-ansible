#########
## Generate the bootstrap scripts
####################

data "template_file" "jumphost-bootstrap-script" {
    template = "${file("${path.module}/template/jumphost-bootstrap.sh.tpl")}"
    vars {
      region = "${var.region}"
      s3_bucket = "${var.vpc_name}-bootstrap"
      s3_object = "bootstrap.zip"
    }
}

data "template_file" "etcd-bootstrap-script" {
    template = "${file("${path.module}/template/etcd-bootstrap.sh.tpl")}"
    vars {
      region = "${var.region}"
      s3_bucket = "${var.vpc_name}-bootstrap"
      s3_object = "bootstrap.zip"
    }
}

data "template_file" "controller-bootstrap-script" {
    template = "${file("${path.module}/template/controller-bootstrap.sh.tpl")}"
    vars {
      region = "${var.region}"
      s3_bucket = "${var.vpc_name}-bootstrap"
      s3_object = "bootstrap.zip"
    }
}

data "template_file" "worker-bootstrap-script" {
    template = "${file("${path.module}/template/worker-bootstrap.sh.tpl")}"
    vars {
      region = "${var.region}"
      s3_bucket = "${var.vpc_name}-bootstrap"
      s3_object = "bootstrap.zip"
    }
}
