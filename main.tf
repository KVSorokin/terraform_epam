terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }
 required_version = ">= 1.0"
}


provider "aws" {

  region = "eu-central-1"

}

data "aws_vpc" "aws-epam-1" {}

output "aws_epam_vpc_id" {
    value = data.aws_vpc.aws-epam-1.id
}

data "aws_subnets" "aws-epam-1" {
}

data "aws_subnet" "aws-epam-1" {
    for_each = toset(data.aws_subnets.aws-epam-1.ids)
    id       = each.value
}

output "subnet_cidr_blocks" {
    value = [for s in data.aws_subnet.aws-epam-1 : s.cidr_block]
}

data "aws_security_groups" "aws-epam-1" {
filter {
    name   = "group-name"
    values = ["aws-epam-1"]
    }
}

output "aws_security_groups" {
    value = data.aws_security_groups.aws-epam-1.ids
}