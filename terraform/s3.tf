provider "archive" {
}

data "archive_file" "bootstrap-archive" {
    depends_on = [
        "null_resource.ansible_cfg",
        "null_resource.ec2_ini",
        "null_resource.certificates",
        "null_resource.vars_yml",
        "null_resource.ssh_cfg"
    ]

    type        = "zip"
    source_dir = "${path.module}/../ansible"
    output_path = "${path.module}/../bootstrap.zip"
}

resource "aws_s3_bucket" "bootstrap-bucket" {
    bucket = "${var.vpc_name}-bootstrap"
    acl = "private"

    tags {
        Owner = "${var.custom_tags["Owner"]}"
        Application = "${var.custom_tags["Application"]}"
        Confidentiality = "${var.custom_tags["Confidentiality"]}"
        Costcenter = "${var.custom_tags["CostCenter"]}"
    }
}

resource "aws_s3_bucket_object" "bootstrap-object" {
    depends_on = [
        "aws_s3_bucket.bootstrap-bucket"
    ]

    bucket = "${var.vpc_name}-bootstrap"
    key = "bootstrap.zip"
    source = "${path.module}/../bootstrap.zip"
}
