# Creates the wildcard certificate *.jayfialkowski.consulting
resource "aws_acm_certificate" "wildcard_website" {
  domain_name               = var.website_domain_main
  subject_alternative_names = ["*.${var.website_domain_main}"]
  validation_method         = "DNS"

  tags = var.tags
}

# Triggers the ACM wildcard certificate validation event
resource "aws_acm_certificate_validation" "wildcard_cert" {
  certificate_arn         = aws_acm_certificate.wildcard_website.arn
  validation_record_fqdns = [for k, v in aws_route53_record.wildcard_validation : v.fqdn]
}

# Get the ARN of the issued certificate
data "aws_acm_certificate" "wildcard_website" {
  depends_on = [
    aws_acm_certificate.wildcard_website,
    aws_route53_record.wildcard_validation,
    aws_acm_certificate_validation.wildcard_cert,
  ]

  domain      = var.website_domain_main
  statuses    = ["ISSUED"]
  most_recent = true
}

resource "aws_cloudfront_distribution" "website_root" {
  enabled             = true
  default_root_object = "index.html"
  price_class         = var.cloudfront_price_class
  aliases             = [local.domain]

  origin {
    origin_id           = "origin-bucket-${aws_s3_bucket.website_bucket.id}"
    domain_name         = aws_s3_bucket.website_bucket.website_endpoint
    connection_attempts = 3
    connection_timeout  = 10

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2", "TLSv1.1", "TLSv1"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "origin-bucket-${aws_s3_bucket.website_bucket.id}"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    cache_policy_id = data.aws_cloudfront_cache_policy.cache_policy.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = data.aws_acm_certificate.wildcard_website.arn
    ssl_support_method  = "sni-only"
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 404
    response_page_path    = "/404.html"
    response_code         = 404
  }

#  logging_config {
#    bucket = aws_s3_bucket.logging_bucket.bucket_domain_name
#    prefix = "${local.domain}/"
#  }

  tags = merge(var.tags, {
    Environment = var.environment
  })
}

resource "aws_cloudfront_distribution" "website_redirect" {
  enabled     = true
  price_class = var.cloudfront_price_class
  aliases     = [local.redirect_domain]
  count       = local.count

  origin {
    origin_id   = "origin-bucket-${aws_s3_bucket.website_redirect.0.id}"
    domain_name = aws_s3_bucket.website_redirect.0.website_endpoint

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2", "TLSv1.1", "TLSv1"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT", "DELETE"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "origin-bucket-${aws_s3_bucket.website_redirect.0.id}"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    cache_policy_id = data.aws_cloudfront_cache_policy.cache_policy.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = data.aws_acm_certificate.wildcard_website.arn
    ssl_support_method  = "sni-only"
  }

  tags = merge(var.tags, {
    Environment = var.environment
  })

}

# retrieve entity to avoid hardcoding default policy uuid
data "aws_cloudfront_cache_policy" "cache_policy" {
  name = "Managed-CachingDisabled"
}
