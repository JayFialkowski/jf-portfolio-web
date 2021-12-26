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
