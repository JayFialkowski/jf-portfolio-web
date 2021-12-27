locals {
  count           = var.environment == "prod" ? 1 : 0
  domain          = var.environment == "prod" ? var.website_domain_main : "${var.environment}.${var.website_domain_main}"
  redirect_domain = "www.${local.domain}"
}
