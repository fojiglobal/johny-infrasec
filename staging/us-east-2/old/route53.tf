################ Create Route53 records ressource
# resource "aws_route53_record" "www_staging" {
#   zone_id = data.aws_route53_zone.johnyfoster_zone.id
#   name    = "www.${data.aws_route53_zone.johnyfoster_zone.name}"
#   type    = "A"
#   ttl     = "300"
#   records = ["10.0.0.1"]
# }

resource "aws_route53_record" "www_staging" {
  zone_id = data.aws_route53_zone.johnyfoster_zone.id
  name    = "www.${var.environment}.johnyfoster.com"
  type    = "A"

  alias {
    name                   = aws_lb.staging_lb.dns_name
    zone_id                = aws_lb.staging_lb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "staging" {
  zone_id = data.aws_route53_zone.johnyfoster_zone.id
  name    = "${var.environment}.johnyfoster.com"
  type    = "A"

  alias {
    name                   = aws_lb.staging_lb.dns_name
    zone_id                = aws_lb.staging_lb.zone_id
    evaluate_target_health = true
  }
}
