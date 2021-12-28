resource "aws_s3_bucket" "logging_bucket" {
  bucket = "jf-portfolio-web-logs"
  acl    = "log-delivery-write"

  tags = var.tags
}
