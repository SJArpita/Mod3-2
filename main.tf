provider "aws" {
  region = "us-east-1"

}

terraform {
  backend "s3" {
    bucket = "sctp-ce9-tfstate"
    key    = "arpita-ce9-module3-lesson2.tfstate" #Change this
    region = "us-east-1"
    checkov:skip=CKV_AWS_62
    checkov:skip=CKV_AWS_145
    checkov:skip=CKV_AWS_18
    checkov:skip=CKV_AWS_144
    checkov:skip=CKV_AWS_61
    checkov:skip=CKV_AWS_6
   
    versioning_configuration {
    status = "Enabled"
  }

  }

  required_version = ">= 1.1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
  }
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix = split("/", data.aws_caller_identity.current.arn)[1]
  account_id  = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "s3_tf" {
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"


}
