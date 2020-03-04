# Copyright 2019-2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#!/bin/bash

set -x

CREDS=$(aws sts assume-role \
--role-arn $CROSS_ACCOUNT_ROLE \
--role-session-name $(date '+%Y%m%d%H%M%S%3N') \
--duration-seconds 3600 \
--query '[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken]' \
--output text)

echo $CREDS

export AWS_DEFAULT_REGION="us-east-1"
echo "export AWS_DEFAULT_REGION=us-east-1"
export AWS_ACCESS_KEY_ID=$(echo $CREDS | cut -d' ' -f1)
echo "export AWS_ACCESS_KEY_ID=$(echo $CREDS | cut -d' ' -f1)"
export AWS_SECRET_ACCESS_KEY=$(echo $CREDS | cut -d' ' -f2)
echo "export AWS_SECRET_ACCESS_KEY=$(echo $CREDS | cut -d' ' -f2)"
export AWS_SESSION_TOKEN=$(echo $CREDS | cut -d' ' -f3)
echo "export AWS_SESSION_TOKEN=$(echo $CREDS | cut -d' ' -f3)"