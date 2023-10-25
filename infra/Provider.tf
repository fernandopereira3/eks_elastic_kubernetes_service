terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.22.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_eks_cluster" "cluster_testes" {
  name = var.cluster
  role_arn = aws_iam_role.iam_role.arn

  vpc_config {
    subnet_ids = [ "module.vpc.private_subnets" ]
  }
}

data "aws_eks_cluster_auth" "aut_cluster_testes" {
  name = var.cluster
}

provider "kubernetes" {
  host = aws_eks_cluster.cluster_testes.id
  # cluster_ca_certificate = base64decode(data.aws_eks_cluster_auth.aut_cluster_testes)
  # token = data.aws_eks_cluster_auth.aut_cluster_testes
}