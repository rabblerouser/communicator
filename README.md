**_DEPRECATED_**: see https://github.com/rabblerouser/group-mailer

Creates a mailing list for Rabble Rouser groups.

## Setup

## Prerequisites

### Nodejs and Packages

- Nodejs 4.3 (Mainly because AWS lambda uses version 4.3)

### AWS

In order to deploy to AWS, make sure the file `credentials` exists under `~/.aws/` and that you have the permissions necessary to the account.

## Make it go

* Build

        STAGE=dev ./go-deploy.sh

_Add environment variable `AWS_PROFILE=<your-aws-profile>` if you have multiple accounts._

        AWS_PROFILE=<your-aws-profile> STAGE=dev ./go-deploy.sh
