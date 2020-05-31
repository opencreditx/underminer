locals {
  cluster_name                 = "myfirstcluster.opencreditx.io"
  master_autoscaling_group_ids = [aws_autoscaling_group.master-us-east-1a-masters-myfirstcluster-opencreditx-io.id]
  master_security_group_ids    = [aws_security_group.masters-myfirstcluster-opencreditx-io.id]
  masters_role_arn             = aws_iam_role.masters-myfirstcluster-opencreditx-io.arn
  masters_role_name            = aws_iam_role.masters-myfirstcluster-opencreditx-io.name
  node_autoscaling_group_ids   = [aws_autoscaling_group.nodes-myfirstcluster-opencreditx-io.id]
  node_security_group_ids      = [aws_security_group.nodes-myfirstcluster-opencreditx-io.id]
  node_subnet_ids              = [aws_subnet.us-east-1a-myfirstcluster-opencreditx-io.id]
  nodes_role_arn               = aws_iam_role.nodes-myfirstcluster-opencreditx-io.arn
  nodes_role_name              = aws_iam_role.nodes-myfirstcluster-opencreditx-io.name
  region                       = "us-east-1"
  route_table_public_id        = aws_route_table.myfirstcluster-opencreditx-io.id
  subnet_us-east-1a_id         = aws_subnet.us-east-1a-myfirstcluster-opencreditx-io.id
  vpc_cidr_block               = aws_vpc.myfirstcluster-opencreditx-io.cidr_block
  vpc_id                       = aws_vpc.myfirstcluster-opencreditx-io.id
}

output "cluster_name" {
  value = "myfirstcluster.opencreditx.io"
}

output "master_autoscaling_group_ids" {
  value = [aws_autoscaling_group.master-us-east-1a-masters-myfirstcluster-opencreditx-io.id]
}

output "master_security_group_ids" {
  value = [aws_security_group.masters-myfirstcluster-opencreditx-io.id]
}

output "masters_role_arn" {
  value = aws_iam_role.masters-myfirstcluster-opencreditx-io.arn
}

output "masters_role_name" {
  value = aws_iam_role.masters-myfirstcluster-opencreditx-io.name
}

output "node_autoscaling_group_ids" {
  value = [aws_autoscaling_group.nodes-myfirstcluster-opencreditx-io.id]
}

output "node_security_group_ids" {
  value = [aws_security_group.nodes-myfirstcluster-opencreditx-io.id]
}

output "node_subnet_ids" {
  value = [aws_subnet.us-east-1a-myfirstcluster-opencreditx-io.id]
}

output "nodes_role_arn" {
  value = aws_iam_role.nodes-myfirstcluster-opencreditx-io.arn
}

output "nodes_role_name" {
  value = aws_iam_role.nodes-myfirstcluster-opencreditx-io.name
}

output "region" {
  value = "us-east-1"
}

output "route_table_public_id" {
  value = aws_route_table.myfirstcluster-opencreditx-io.id
}

output "subnet_us-east-1a_id" {
  value = aws_subnet.us-east-1a-myfirstcluster-opencreditx-io.id
}

output "vpc_cidr_block" {
  value = aws_vpc.myfirstcluster-opencreditx-io.cidr_block
}

output "vpc_id" {
  value = aws_vpc.myfirstcluster-opencreditx-io.id
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_autoscaling_group" "master-us-east-1a-masters-myfirstcluster-opencreditx-io" {
  name                 = "master-us-east-1a.masters.myfirstcluster.opencreditx.io"
  launch_configuration = aws_launch_configuration.master-us-east-1a-masters-myfirstcluster-opencreditx-io.id
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.us-east-1a-myfirstcluster-opencreditx-io.id]

  tag {
    key                 = "KubernetesCluster"
    value               = "myfirstcluster.opencreditx.io"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "master-us-east-1a.masters.myfirstcluster.opencreditx.io"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-1a"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  tag {
    key                 = "kops.k8s.io/instancegroup"
    value               = "master-us-east-1a"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-myfirstcluster-opencreditx-io" {
  name                 = "nodes.myfirstcluster.opencreditx.io"
  launch_configuration = aws_launch_configuration.nodes-myfirstcluster-opencreditx-io.id
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.us-east-1a-myfirstcluster-opencreditx-io.id]

  tag {
    key                 = "KubernetesCluster"
    value               = "myfirstcluster.opencreditx.io"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "nodes.myfirstcluster.opencreditx.io"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  tag {
    key                 = "kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-myfirstcluster-opencreditx-io" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                     = "myfirstcluster.opencreditx.io"
    Name                                                  = "a.etcd-events.myfirstcluster.opencreditx.io"
    "k8s.io/etcd/events"                                  = "a/a"
    "k8s.io/role/master"                                  = "1"
    "kubernetes.io/cluster/myfirstcluster.opencreditx.io" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-myfirstcluster-opencreditx-io" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                                     = "myfirstcluster.opencreditx.io"
    Name                                                  = "a.etcd-main.myfirstcluster.opencreditx.io"
    "k8s.io/etcd/main"                                    = "a/a"
    "k8s.io/role/master"                                  = "1"
    "kubernetes.io/cluster/myfirstcluster.opencreditx.io" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-myfirstcluster-opencreditx-io" {
  name = "masters.myfirstcluster.opencreditx.io"
  role = aws_iam_role.masters-myfirstcluster-opencreditx-io.name
}

resource "aws_iam_instance_profile" "nodes-myfirstcluster-opencreditx-io" {
  name = "nodes.myfirstcluster.opencreditx.io"
  role = aws_iam_role.nodes-myfirstcluster-opencreditx-io.name
}

resource "aws_iam_role" "masters-myfirstcluster-opencreditx-io" {
  name = "masters.myfirstcluster.opencreditx.io"
  assume_role_policy = file(
    "${path.module}/data/aws_iam_role_masters.myfirstcluster.opencreditx.io_policy",
  )
}

resource "aws_iam_role" "nodes-myfirstcluster-opencreditx-io" {
  name = "nodes.myfirstcluster.opencreditx.io"
  assume_role_policy = file(
    "${path.module}/data/aws_iam_role_nodes.myfirstcluster.opencreditx.io_policy",
  )
}

resource "aws_iam_role_policy" "masters-myfirstcluster-opencreditx-io" {
  name = "masters.myfirstcluster.opencreditx.io"
  role = aws_iam_role.masters-myfirstcluster-opencreditx-io.name
  policy = file(
    "${path.module}/data/aws_iam_role_policy_masters.myfirstcluster.opencreditx.io_policy",
  )
}

resource "aws_iam_role_policy" "nodes-myfirstcluster-opencreditx-io" {
  name = "nodes.myfirstcluster.opencreditx.io"
  role = aws_iam_role.nodes-myfirstcluster-opencreditx-io.name
  policy = file(
    "${path.module}/data/aws_iam_role_policy_nodes.myfirstcluster.opencreditx.io_policy",
  )
}

resource "aws_internet_gateway" "myfirstcluster-opencreditx-io" {
  vpc_id = aws_vpc.myfirstcluster-opencreditx-io.id

  tags = {
    KubernetesCluster                                     = "myfirstcluster.opencreditx.io"
    Name                                                  = "myfirstcluster.opencreditx.io"
    "kubernetes.io/cluster/myfirstcluster.opencreditx.io" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-myfirstcluster-opencreditx-io-8a57e234b237e08b223ee6b9003b0ce0" {
  key_name = "kubernetes.myfirstcluster.opencreditx.io-8a:57:e2:34:b2:37:e0:8b:22:3e:e6:b9:00:3b:0c:e0"
  public_key = file(
    "${path.module}/data/aws_key_pair_kubernetes.myfirstcluster.opencreditx.io-8a57e234b237e08b223ee6b9003b0ce0_public_key",
  )
}

resource "aws_launch_configuration" "master-us-east-1a-masters-myfirstcluster-opencreditx-io" {
  name_prefix                 = "master-us-east-1a.masters.myfirstcluster.opencreditx.io-"
  image_id                    = "ami-0938c52697eb48ee2"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.kubernetes-myfirstcluster-opencreditx-io-8a57e234b237e08b223ee6b9003b0ce0.id
  iam_instance_profile        = aws_iam_instance_profile.masters-myfirstcluster-opencreditx-io.id
  security_groups             = [aws_security_group.masters-myfirstcluster-opencreditx-io.id]
  associate_public_ip_address = true
  user_data = file(
    "${path.module}/data/aws_launch_configuration_master-us-east-1a.masters.myfirstcluster.opencreditx.io_user_data",
  )

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-myfirstcluster-opencreditx-io" {
  name_prefix                 = "nodes.myfirstcluster.opencreditx.io-"
  image_id                    = "ami-0938c52697eb48ee2"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.kubernetes-myfirstcluster-opencreditx-io-8a57e234b237e08b223ee6b9003b0ce0.id
  iam_instance_profile        = aws_iam_instance_profile.nodes-myfirstcluster-opencreditx-io.id
  security_groups             = [aws_security_group.nodes-myfirstcluster-opencreditx-io.id]
  associate_public_ip_address = true
  user_data = file(
    "${path.module}/data/aws_launch_configuration_nodes.myfirstcluster.opencreditx.io_user_data",
  )

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "route-0-0-0-0--0" {
  route_table_id         = aws_route_table.myfirstcluster-opencreditx-io.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myfirstcluster-opencreditx-io.id
}

resource "aws_route_table" "myfirstcluster-opencreditx-io" {
  vpc_id = aws_vpc.myfirstcluster-opencreditx-io.id

  tags = {
    KubernetesCluster                                     = "myfirstcluster.opencreditx.io"
    Name                                                  = "myfirstcluster.opencreditx.io"
    "kubernetes.io/cluster/myfirstcluster.opencreditx.io" = "owned"
    "kubernetes.io/kops/role"                             = "public"
  }
}

resource "aws_route_table_association" "us-east-1a-myfirstcluster-opencreditx-io" {
  subnet_id      = aws_subnet.us-east-1a-myfirstcluster-opencreditx-io.id
  route_table_id = aws_route_table.myfirstcluster-opencreditx-io.id
}

resource "aws_security_group" "masters-myfirstcluster-opencreditx-io" {
  name        = "masters.myfirstcluster.opencreditx.io"
  vpc_id      = aws_vpc.myfirstcluster-opencreditx-io.id
  description = "Security group for masters"

  tags = {
    KubernetesCluster                                     = "myfirstcluster.opencreditx.io"
    Name                                                  = "masters.myfirstcluster.opencreditx.io"
    "kubernetes.io/cluster/myfirstcluster.opencreditx.io" = "owned"
  }
}

resource "aws_security_group" "nodes-myfirstcluster-opencreditx-io" {
  name        = "nodes.myfirstcluster.opencreditx.io"
  vpc_id      = aws_vpc.myfirstcluster-opencreditx-io.id
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                                     = "myfirstcluster.opencreditx.io"
    Name                                                  = "nodes.myfirstcluster.opencreditx.io"
    "kubernetes.io/cluster/myfirstcluster.opencreditx.io" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-myfirstcluster-opencreditx-io.id
  source_security_group_id = aws_security_group.masters-myfirstcluster-opencreditx-io.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = aws_security_group.nodes-myfirstcluster-opencreditx-io.id
  source_security_group_id = aws_security_group.masters-myfirstcluster-opencreditx-io.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = aws_security_group.nodes-myfirstcluster-opencreditx-io.id
  source_security_group_id = aws_security_group.nodes-myfirstcluster-opencreditx-io.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = aws_security_group.masters-myfirstcluster-opencreditx-io.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = aws_security_group.masters-myfirstcluster-opencreditx-io.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = aws_security_group.nodes-myfirstcluster-opencreditx-io.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-myfirstcluster-opencreditx-io.id
  source_security_group_id = aws_security_group.nodes-myfirstcluster-opencreditx-io.id
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-myfirstcluster-opencreditx-io.id
  source_security_group_id = aws_security_group.nodes-myfirstcluster-opencreditx-io.id
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-myfirstcluster-opencreditx-io.id
  source_security_group_id = aws_security_group.nodes-myfirstcluster-opencreditx-io.id
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-myfirstcluster-opencreditx-io.id
  source_security_group_id = aws_security_group.nodes-myfirstcluster-opencreditx-io.id
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = aws_security_group.masters-myfirstcluster-opencreditx-io.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = aws_security_group.nodes-myfirstcluster-opencreditx-io.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-east-1a-myfirstcluster-opencreditx-io" {
  vpc_id            = aws_vpc.myfirstcluster-opencreditx-io.id
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-east-1a"

  tags = {
    KubernetesCluster                                     = "myfirstcluster.opencreditx.io"
    Name                                                  = "us-east-1a.myfirstcluster.opencreditx.io"
    SubnetType                                            = "Public"
    "kubernetes.io/cluster/myfirstcluster.opencreditx.io" = "owned"
    "kubernetes.io/role/elb"                              = "1"
  }
}

resource "aws_vpc" "myfirstcluster-opencreditx-io" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                                     = "myfirstcluster.opencreditx.io"
    Name                                                  = "myfirstcluster.opencreditx.io"
    "kubernetes.io/cluster/myfirstcluster.opencreditx.io" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "myfirstcluster-opencreditx-io" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                                     = "myfirstcluster.opencreditx.io"
    Name                                                  = "myfirstcluster.opencreditx.io"
    "kubernetes.io/cluster/myfirstcluster.opencreditx.io" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "myfirstcluster-opencreditx-io" {
  vpc_id          = aws_vpc.myfirstcluster-opencreditx-io.id
  dhcp_options_id = aws_vpc_dhcp_options.myfirstcluster-opencreditx-io.id
}

terraform {
  required_version = ">= 0.9.3"
}

