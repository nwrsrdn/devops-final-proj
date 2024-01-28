resource "aws_security_group" "eks_cluster_public_sg" {
  vpc_id = aws_vpc.eks_cluster_vpc.id

  tags = {
    Name = "${var.Engineer}_eks_public_sg"
  }
}

resource "aws_security_group_rule" "eks_cluster_public_sg_http_rule" {
  type              = "ingress"
  security_group_id = aws_security_group.eks_cluster_public_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "eks_cluster_public_sg_https_rule" {
  type              = "egress"
  security_group_id = aws_security_group.eks_cluster_public_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
