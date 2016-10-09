#!/usr/bin/env bash

rm terraform/send-email-function.zip
zip -j send-email-function.zip send-email-function/* && mv send-email-function.zip terraform
pushd terraform
terraform apply
popd
