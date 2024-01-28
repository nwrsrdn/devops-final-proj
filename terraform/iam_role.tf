resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks_cluster_role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

resource "aws_iam_role" "eks_node_group_role" {
  name               = "eks_node_group_role"
  assume_role_policy = data.aws_iam_policy_document.node_group_assume_role.json
}

resource "aws_iam_role" "eks_load_balancer_role" {
  name = "AmazonEKSLoadBalancerRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::966437228244:oidc-provider/${trimprefix(aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://")}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${trimprefix(aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://")}:sub" : "system:serviceaccount:kube-system:aws-load-balancer-controller",
            "${trimprefix(aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://")}:aud" : ["sts.amazonaws.com"]
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "load_balancer_controller_policy" {
  name   = "AWSLoadBalancerControllerPolicy"
  policy = file("./load_balancer_policy.json")
}

resource "aws_iam_role_policy_attachment" "load_balancer_controller_policy_attachment" {
  policy_arn = aws_iam_policy.load_balancer_controller_policy.arn
  role       = aws_iam_role.eks_load_balancer_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_pods_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_nodes_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_cni_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_ec2_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_role.name
}