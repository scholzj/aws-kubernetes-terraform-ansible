---

internal_cidr: "${vpc_cidr}" # Includes VPC and Kubernetes subnets
kubernetes_service_cluster_cidr: "${service_cidr}"
kubernetes_pod_cluster_cidr: "${pod_cidr}"
kubernetes_cluster_dns: "${cluster_dns}"
kubernetes_api_endpoint: "${api_endpoint}"

kubernetes_cluster_name: "${cluster_name}"

kubernetes_version: "v1.4.6"
kubernetes_download_path: "https://storage.googleapis.com/kubernetes-release/release/{{ kubernetes_version }}/bin/linux/amd64"
kubernetes_darwin_download_path: "https://storage.googleapis.com/kubernetes-release/release/{{ kubernetes_version }}/bin/darwin/amd64"

aws_region: "${aws_region}"
aws_availability_zone: "${aws_zone}"

admin_username: "admin"
admin_password: "${admin_password}"
scheduler_username: "scheduler"
scheduler_password: "${scheduler_password}"
kubelet_username: "kubelet"
kubelet_password: "${kubelet_password}"
