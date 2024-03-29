# Provides details about the zone
data "aws_route53_zone" "main" {
  name         = var.website_domain_main
  private_zone = false
}

# Validates the ACM wildcard by creating a Route53 record (as `validation_method` is set to `DNS` in the aws_acm_certificate resource)
resource "aws_route53_record" "wildcard_validation" {
  for_each = {
    for dvo in aws_acm_certificate.wildcard_website.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name            = each.value["name"]
  type            = each.value["type"]
  zone_id         = data.aws_route53_zone.main.zone_id
  records         = [each.value["record"]]
  allow_overwrite = true
  ttl             = "60"
}

# Creates the DNS record to point on the main CloudFront distribution ID
resource "aws_route53_record" "website_root_record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = local.domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website_root.domain_name
    zone_id                = aws_cloudfront_distribution.website_root.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "website_redirect_record" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = local.redirect_domain
  type    = "A"
  count   = local.count

  alias {
    name                   = aws_cloudfront_distribution.website_redirect.0.domain_name
    zone_id                = aws_cloudfront_distribution.website_redirect.0.hosted_zone_id
    evaluate_target_health = false
  }
}
