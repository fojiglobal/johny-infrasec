####### DNS Zone Data Lookup
data "aws_route53_zone" "johnyfoster_zone" {
  name = "johnyfoster.com."
}

######## Web Base AMI Data Lookup
data "aws_ami" "staging_ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["test-web-server-*"]
  }
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