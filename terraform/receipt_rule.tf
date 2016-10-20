resource "aws_ses_receipt_rule_set" "main" {
  rule_set_name = "group_rules"
}

resource "aws_ses_active_receipt_rule_set" "main" {
  rule_set_name = "group_rules"
}

resource "aws_ses_receipt_rule" "store" {
  name          = "save_to_s3"
  rule_set_name = "group_rules"
  recipients    = ["lists@${var.mail_domain_name}"]
  enabled       = true
  tls_policy    = "Require"
  scan_enabled  = true

  add_header_action {
    header_name  = "Custom-Header"
    header_value = "Testing"
    position     = "0"
  }

  s3_action {
    bucket_name = "${var.email_list_s3_bucket_name}"
    position    = "1"
  }
}
