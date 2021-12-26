# CodeBuild role
resource "aws_iam_role" "code_build" {
  name = "jf-portfolio-web-code-build-role"

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
}

resource "aws_iam_role_policy" "code_build_role_policy" {
  role = aws_iam_role.code_build.name
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Resource" : [
            "*"
          ],
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
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
      name  = "deploy_env"
      value = var.environment
      type  = "PLAINTEXT"
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
    type                = "GITHUB"
    report_build_status = true
    location            = "https://github.com/JayFialkowski/jf-portfolio-web.git"
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
