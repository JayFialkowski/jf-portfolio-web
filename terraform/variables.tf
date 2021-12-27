variable "environment" {
  description = "environment being managed"
  type        = string
}

variable "code_build_base_branch" {
  description = "github branch to base pipeline on"
  type        = string
}

variable "code_build_managed_policy_arn" {
  description = "ARN of the policy created by AWS for CodeBuild management"
  type        = string
}

variable "website_domain_main" {
  type    = string
  default = "jayfialkowski.consulting"
}

variable "cloudfront_price_class" {
  # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PriceClass.html
  description = "Price Class to associate with CloudFront distribution"
  type        = string
  default     = "PriceClass_100"
}

variable "tags" {
  type = map(string)
  default = {
    Project   = "portfolio"
    ManagedBy = "terraform"
  }
}
