resource "aws_s3_bucket" "state_bucket" {
  bucket = "jf-portfolio-web-tfstate"
  tags = {
    Project = "portfolio"
  }
}
