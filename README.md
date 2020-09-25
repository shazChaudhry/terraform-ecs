# This repo will be archived soon

 Once [compose-cli](https://github.com/docker/compose-cli) is generally available, This repo will then be archived.
 
This CLI tool makes it easy to run containers in the cloud using either Amazon Elastic Container Service (ECS) or Microsoft Azure Container Instances (ACI) using the Docker commands you already know.
 
===========================================


## Prerequisites
- Terraform v0.12.3 _(Code has been tested with this version)_
- Ensure that AWS credentials are available at: "~/.aws/credentials" on the host dev machine
```
      [default]
      aws_access_key_id = <KEY>
      aws_secret_access_key = <SECRET_KEY>
      region = <REGION>
```
- Ensure that a S3 bucket as a backend type is created. See the docs [here](https://www.terraform.io/docs/backends/types/s3.html)
```
      terraform {
        # It is expected that the bucket, globally unique, already exists
        backend "s3" {
          # you will need a globally unique bucket name
          bucket  = "<BUCKET_NAME>"
          key     = "<KEY>.tfstate"
          region  = "<REGION>"
          encrypt = true
        }
      }
```
