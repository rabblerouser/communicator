resource "aws_route53_record" "ses_verification" {
  zone_id = "${var.aws_mail_zone_id}"
  name = "_amazonses.${var.mail_domain_name}"
  type = "TXT"
  ttl = "300"
  records = [
    "${var.aws_ses_verification_token}"
  ]
}

resource "aws_route53_record" "mail" {
  zone_id = "${var.aws_mail_zone_id}"
  name = "${var.mail_domain_name}"
  type = "MX"
  ttl = "300"
  records = [
    "10 inbound-smtp.${var.aws_region}.amazonaws.com"
  ]
}
