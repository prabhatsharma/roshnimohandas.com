rem clear the temp pubic directory
rm -rf public

rem Generate static website. Files will be placed in public folder
hugo

rem Move the files to S3 bucket for hosting
aws s3 sync ./public s3://roshnimohandas.com/ --acl=public-read --profile=personal

rem invalidate cloudfront cache so that latest files can be served
aws cloudfront create-invalidation --distribution-id E2MZ46EDHY6R32 --paths=/* --profile=personal
