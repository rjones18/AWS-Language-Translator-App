resource "aws_apprunner_custom_domain_association" "this" {
  domain_name = var.domain_name
  service_arn = module.translator_apprunner.service_arn
}

locals {
  apprunner_cert_validation_records = tolist(aws_apprunner_custom_domain_association.this.certificate_validation_records)
}

resource "aws_route53_record" "apprunner_cert_validation" {
  # keys are static: "0", "1", "2", ...
  for_each = {
    for idx, r in local.apprunner_cert_validation_records :
    tostring(idx) => r
  }

  zone_id = data.aws_route53_zone.this.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.value]
}


resource "aws_route53_record" "apprunner_domain" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.domain_name
  type    = "CNAME"
  ttl     = 300
  records = [aws_apprunner_custom_domain_association.this.dns_target]
}
