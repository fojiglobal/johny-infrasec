####### DNS Zone Data Lookup
data "aws_route53_zone" "johnyfoster_zone" {
  name = "johnyfoster.com."
}

####### Certificate Data Lookup
data "aws_acm_certificate" "amazon_issued" {
  domain      = "*.johnyfoster.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

output "certificate_arn" {
  value = data.aws_acm_certificate.amazon_issued.arn
}

# data.aws_acm_certificate.amazon_issued.arn