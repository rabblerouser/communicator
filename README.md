Creates a mailing list for Rabble Rouser groups.

## Setup

* Get zone id (from a list of hosted zones):

        aws route53 list-hosted-zones

* Verify domain:

        aws ses verify-domain-identity --domain <domain.com>

## Make it go

* Build

        ./deploy.sh

