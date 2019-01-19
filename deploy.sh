#!/bin/sh

# clear the temp pubic directory
rm -rf public

# Generate static website. Files will be placed in public folder
hugo

# Move the files to S3 bucket for hosting
aws s3 sync ./public s3://roshnimohandas.com/ --acl=public-read --profile=personal

# invalidate cloudfront cache so that latest files can be served
aws cloudfront create-invalidation --distribution-id E3VMAUJJRCAS0D --paths=/* --profile=personal
