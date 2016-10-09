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

resource "aws_iam_role" "iam_for_lambda" {
    name = "iam_for_lambda"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  EOF
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${aws_s3_bucket.email.id}"
  lambda_function {
    lambda_function_arn = "${aws_lambda_function.send-email.arn}"
    events = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id = "AllowExecutionFromS3Bucket"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.send-email.arn}"
  principal = "s3.amazonaws.com"
  source_arn = "${aws_s3_bucket.email.arn}"
}

resource "aws_lambda_function" "send-email" {
  filename = "send-email-function.zip"
  function_name = "send_email"
  role = "${aws_iam_role.iam_for_lambda.arn}"
  handler = "handler.handler"
  runtime = "nodejs4.3"
}
