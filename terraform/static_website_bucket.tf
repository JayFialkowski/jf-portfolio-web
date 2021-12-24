resource "aws_s3_bucket" "website_bucket" {
  bucket = "jf-portfolio-web-${var.environment}"
  acl    = "public-read"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" : [
          "arn:aws:s3:::jf-portfolio-web-${var.environment}/*"
        ]
      },
      {
        "Sid" : "CodeBuildUploadArtifacts",
        "Action" : "s3:*",
        "Effect" : "Allow",
        "Resource" : "arn:aws:s3:::jf-portfolio-web-${var.environment}/*",
        "Principal" : {
          "AWS" : [
            aws_iam_role.code_build.arn
          ]
        }
      }
    ]
  })

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Environment = var.environment
    Project     = "portfolio"
  }
}
