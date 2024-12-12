####### DNS Zone Data Lookup
data "aws_route53_zone" "johnylabs_zone" {
  name = "johnylabs.com."
}

####### Certificate Data Lookup
data "aws_acm_certificate" "amazon_issued" {
  domain      = "*.johnylabs.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

output "certificate_arn" {
  value = data.aws_acm_certificate.amazon_issued.arn
}

# data.aws_acm_certificate.amazon_issued.arn

########### IAM Role Data Lookup

# data "aws_iam_instance_profile" "am_instance_profile_name" {
#   name = "base-ec2-role"
# }