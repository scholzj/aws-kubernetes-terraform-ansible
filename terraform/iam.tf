##########################
# IAM: Policies and Roles
##########################

# The following Roles and Policy are mostly for future use

resource "aws_iam_role" "jumphost" {
  name = "${var.vpc_name}-jumphost"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role" "controller" {
  name = "${var.vpc_name}-controller"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role" "worker" {
  name = "${var.vpc_name}-worker"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role" "etcd" {
  name = "${var.vpc_name}-etcd"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Role policy
resource "aws_iam_role_policy" "jumphost" {
  name = "${var.vpc_name}-jumphost"
  role = "${aws_iam_role.jumphost.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action" : ["ec2:Describe*"],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Effect":"Allow",
      "Action":[
        "s3:GetObject"
      ],
      "Resource":"arn:aws:s3:::${var.vpc_name}-bootstrap/*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "controller" {
  name = "${var.vpc_name}-controller"
  role = "${aws_iam_role.controller.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action" : ["ec2:*"],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Action" : ["elasticloadbalancing:*"],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Action": "route53:*",
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Action": "ecr:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect":"Allow",
      "Action":[
        "s3:GetObject"
      ],
      "Resource":"arn:aws:s3:::${var.vpc_name}-bootstrap/*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "worker" {
  name = "${var.vpc_name}-worker"
  role = "${aws_iam_role.worker.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "ec2:*",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "ec2:AttachVolume",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "ec2:DetachVolume",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": ["route53:*"],
        "Resource": ["*"]
      },
      {
        "Effect": "Allow",
        "Action": [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:BatchGetImage"
        ],
        "Resource": "*"
      },
      {
        "Effect":"Allow",
        "Action":[
          "s3:GetObject"
        ],
        "Resource":"arn:aws:s3:::${var.vpc_name}-bootstrap/*"
      }
    ]
}
EOF
}

resource "aws_iam_role_policy" "etcd" {
  name = "${var.vpc_name}-etcd"
  role = "${aws_iam_role.etcd.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "ec2:Describe*",
        "Resource": "*"
      },
      {
        "Effect":"Allow",
        "Action":[
          "s3:GetObject"
        ],
        "Resource":"arn:aws:s3:::${var.vpc_name}-bootstrap/*"
      }
    ]
}
EOF
}

# IAM Instance Profile for Controller
resource  "aws_iam_instance_profile" "jumphost" {
 name = "${var.vpc_name}-jumphost"
 roles = ["${aws_iam_role.jumphost.name}"]
}

resource  "aws_iam_instance_profile" "controller" {
 name = "${var.vpc_name}-controller"
 roles = ["${aws_iam_role.controller.name}"]
}

resource  "aws_iam_instance_profile" "worker" {
 name = "${var.vpc_name}-worker"
 roles = ["${aws_iam_role.worker.name}"]
}

resource  "aws_iam_instance_profile" "etcd" {
 name = "${var.vpc_name}-etcd"
 roles = ["${aws_iam_role.etcd.name}"]
}
