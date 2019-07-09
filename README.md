# WORK IN PROGRESS
===========================================


## Prerequisites
- Ensure that AWS credentials are available at: "~/.aws/credentials" on the host dev machine
```
      [default]
      aws_access_key_id = <KEY>
      aws_secret_access_key = <SECRET>
      region = <REGION>
```
- Ensure that a S3 bucket as a backend type is created. See the docs [here](https://www.terraform.io/docs/backends/types/s3.html)
```
      terraform {
        # It is expected that the bucket, globally unique, already exists
        backend "s3" {
          # you will need a globally unique bucket name
          bucket  = "ci.terraform"
          key     = "eks/terraform.tfstate"
          region  = "<REGION>"
          encrypt = true
        }
      }
```
