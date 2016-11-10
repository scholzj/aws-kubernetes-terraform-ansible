##########################
# IAM: Policies and Roles
##########################

# The following Roles and Policy are mostly for future use

resource "aws_iam_role" "kubernetes-controller" {
  name = "dave-k8s-controller"
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

resource "aws_iam_role" "kubernetes-worker" {
  name = "dave-k8s-worker"
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

resource "aws_iam_role" "kubernetes-etcd" {
  name = "dave-k8s-etcd"
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
resource "aws_iam_role_policy" "kubernetes-controller" {
  name = "dave-k8s-controller"
  role = "${aws_iam_role.kubernetes-controller.id}"
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
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "kubernetes-worker" {
  name = "dave-k8s-worker"
  role = "${aws_iam_role.kubernetes-worker.id}"
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
      }
    ]
  }
EOF
}

/*resource "aws_iam_role_policy" "kubernetes-etcd" {
  name = "dave-k8s-etcd"
  role = "${aws_iam_role.kubernetes-etcd.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "ec2:Describe*",
        "Resource": "*"
      }
    ]
  }
EOF
}*/

# IAM Instance Profile for Controller
resource  "aws_iam_instance_profile" "kubernetes-controller" {
 name = "dave-k8s-controller"
 roles = ["${aws_iam_role.kubernetes-controller.name}"]
}

resource  "aws_iam_instance_profile" "kubernetes-worker" {
 name = "dave-k8s-worker"
 roles = ["${aws_iam_role.kubernetes-worker.name}"]
}

resource  "aws_iam_instance_profile" "kubernetes-etcd" {
 name = "dave-k8s-etcd"
 roles = ["${aws_iam_role.kubernetes-etcd.name}"]
}
