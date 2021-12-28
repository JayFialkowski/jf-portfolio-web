# CodeBuild role
resource "aws_iam_role" "code_build" {
  name = "jf-portfolio-web-code-build-role-${var.environment}"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "codebuild.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        },
      ]
    }
  )

  managed_policy_arns = [
    var.code_build_managed_policy_arn # TODO - need to figure out how to retrieve this dynamically
  ]

}

resource "aws_iam_role_policy" "code_build_role_policy" {
  name = "terraform_policy"
  role = aws_iam_role.code_build.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Resource" : [
            "${aws_s3_bucket.state_bucket.arn}/*.terraform.state"
          ],
          "Action" : [
            "s3:GetObject",
            "s3:PutObject"
          ]
        }
      ]
    }
  )
}

# CodeBuild project
resource "aws_codebuild_project" "pipeline" {
  name                   = "jf-portfolio-web-${var.environment}"
  description            = "CodeBuild pipeline for ${var.environment} environment of jf-portfolio-web"
  concurrent_build_limit = 1
  build_timeout          = 5
  queued_timeout         = 480
  service_role           = aws_iam_role.code_build.arn
  badge_enabled          = true

  # typically, these environment variables would be key names in SecretsManager,
  # but that is a paid feature and this is a demo project - so instead the id/key are
  # managed manually in AWS Console and ignored by terraform
  lifecycle {
    ignore_changes = [
      environment.0.environment_variable.0,
      environment.0.environment_variable.1,
    ]
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    type                        = "LINUX_CONTAINER"
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "AWS_ACCESS_KEY_ID"
      type  = "PLAINTEXT"
      value = ""
    }

    environment_variable {
      name  = "AWS_SECRET_ACCESS_KEY"
      type  = "PLAINTEXT"
      value = ""
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      type  = "PLAINTEXT"
      value = "us-east-1"
    }

    environment_variable {
      name  = "DEPLOY_ENV"
      type  = "PLAINTEXT"
      value = var.environment
    }

    environment_variable {
      name  = "DOMAIN"
      type  = "PLAINTEXT"
      value = local.domain
    }
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
    s3_logs {
      status = "DISABLED"
    }
  }

  source {
    type     = "GITHUB"
    location = "https://github.com/JayFialkowski/jf-portfolio-web.git"
  }

  source_version = var.environment != "sandbox" ? var.code_build_base_branch : null

  tags = {
    Environment = var.environment
    Project     = "portfolio"
  }
}

# CodeBuild webhook trigger
resource "aws_codebuild_webhook" "trigger" {
  project_name = aws_codebuild_project.pipeline.name
  build_type   = "BUILD"

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }
    filter {
      type                    = "HEAD_REF"
      pattern                 = coalesce(aws_codebuild_project.pipeline.source_version, "^(master|develop)$")
      exclude_matched_pattern = var.environment == "sandbox"
    }

  }

}
