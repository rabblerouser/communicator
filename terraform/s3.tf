resource "aws_s3_bucket" "email" {
  bucket = "${var.email_list_s3_bucket_name}"
  acl    = "private"

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "GiveSESPermissionToWriteEmail",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "ses.amazonaws.com"
                ]
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::${var.email_list_s3_bucket_name}/*",
            "Condition": {
                "StringEquals": {
                    "aws:Referer": "${var.aws_account_id}"
                }
            }
        }
    ]
}
EOF

  tags {
    Name = "Email list"
  }
}
