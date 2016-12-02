#!/usr/bin/env bash
set -e

# move this out later.
if sls --version; then
  echo "serverless is installed"
else
  serverlessVersion=1.2.1
  echo "installing serverless ${serverlessVersion}"
  npm install -g serverless@${serverlessVersion}
fi

rm -rf node_modules/

npm install --production

sls deploy -v --stage ${STAGE}