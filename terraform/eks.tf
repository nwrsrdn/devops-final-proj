resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.Engineer}_eks_cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids         = concat(aws_subnet.eks_public_subnet[*].id, aws_subnet.eks_private_subnet[*].id)
    security_group_ids = [aws_security_group.eks_cluster_public_sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_policy_attachment,
    aws_iam_role_policy_attachment.eks_cluster_role_pods_policy_attachment
  ]

  tags = {
    Name = "${var.Engineer}_eks_cluster"
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks_node_group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = aws_subnet.eks_private_subnet[*].id
  instance_types  = ["t3.large"]
  capacity_type   = "SPOT"

  remote_access {
    ec2_ssh_key               = "Erwin-macbook"
    source_security_group_ids = [aws_security_group.eks_cluster_public_sg.id]
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_iam_role_policy_attachment.eks_cluster_role_nodes_policy_attachment,
    aws_iam_role_policy_attachment.eks_cluster_role_cni_policy_attachment,
    aws_iam_role_policy_attachment.eks_cluster_role_ec2_policy_attachment
  ]
}
