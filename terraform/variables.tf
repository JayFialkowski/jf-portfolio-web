variable "environment" {
  description = "environment being managed"
  type        = string
}

variable "code_build_base_branch" {
  description = "github branch to base pipeline on"
  type        = string
}
