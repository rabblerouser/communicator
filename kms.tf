resource "aws_kms_key" "email_lists" {
  description             = "Encryption key for email lists"
  deletion_window_in_days = 10

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {"AWS": "arn:aws:iam::${var.aws_account_id}:root"},
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "AllowSESToEncryptMessagesBelongingToThisAccount",
            "Effect": "Allow",
            "Principal": {
                "Service": "ses.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt",
                "kms:GenerateDataKey*"
            ],
            "Resource": "*",
            "Condition": {
                "Null": {
                    "kms:EncryptionContext:aws:ses:rule-name": "false",
                    "kms:EncryptionContext:aws:ses:message-id": "false"
                },
                "StringEquals": {
                    "kms:EncryptionContext:aws:ses:source-account": "${var.aws_account_id}"
                }
            }
        }
    ]
}
EOF

}
