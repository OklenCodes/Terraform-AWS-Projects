module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.13.1"
  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version
  subnet_ids      = module.vpc.private_subnets

  enable_irsa = true

  tags = {
    cluster = "test"
  }

  vpc_id = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = ["t3.medium"]
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  }

  eks_managed_node_groups = {

    node_group = {
      min_size     = 2
      max_size     = 6
      desired_size = 2
    }
  }
}

resource "aws_iam_user" "eks_admin_user" {
  name = "OklenTestUser"  # Assuming this user does not already exists
}

resource "aws_iam_user_policy_attachment" "eks_admin_user_policy" {
  user       = aws_iam_user.eks_admin_user.name
  policy_arn = "arn:aws:iam::498543162511:user/OklenTestUser"
}

resource "aws_eks_access_entry" "oklen-eks-gjm9k6zu" {
  cluster_name = "oklen-eks-HETf4Yk7"
  principal_arn = aws_iam_user.eks_admin_user.arn
}
