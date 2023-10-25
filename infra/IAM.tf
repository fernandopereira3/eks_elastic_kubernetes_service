resource "aws_iam_role" "iam_role" {
  name = "${var.cargoIAM}_cargo"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = ["ec2.amazonaws.com",
          "ecs-tasks.amazonaws.com"]
        }
      },
    ]
  })
}

# ESTA ROLE PERMITE QUE O ECS (ELASTIC CONTAINER SERVICE) ACESSE O ECR (ELASTIC CONTAINER REPOSITORY)
# 
resource "aws_iam_role_policy" "ekc_policy" {
  name = "ekc_policy"
  role = aws_iam_role.iam_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BathCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogsStream",
          "logs:PutLogEvents",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.cargoIAM}_perfil"
  role = aws_iam_role.iam_role.name
}