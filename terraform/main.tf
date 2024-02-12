terraform {
    required_version = ">= 1.2.0"

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
}

provider "aws" {
    region = var.aws_region
}

# IAM Role for Redshift to access S3
resource "aws_iam_role" "redshift_role" {
    name               = var.iam_role_name
    assume_role_policy = jsonencode({
        Version   = "2012-10-17"
        Statement = [
            {
                Action    = "sts:AssumeRole"
                Effect    = "Allow"
                Principal = { Service = "redshift.amazonaws.com" }
            },
        ]
    })
    managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
}

# Redshift Cluster
resource "aws_redshift_cluster" "redshift" {
    cluster_identifier   = "unique-redshift-cluster-pipeline-20240208" # Updated identifier
    skip_final_snapshot  = true
    master_username      = "awsuser"
    master_password      = var.db_password
    node_type            = "dc2.large"
    cluster_type         = "single-node"
    publicly_accessible  = true
    iam_roles            = [aws_iam_role.redshift_role.arn]
    vpc_security_group_ids = [aws_security_group.sg_redshift.id]
}

# Security Group for Redshift
resource "aws_security_group" "sg_redshift" {
    name = var.security_group_name
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# S3 Bucket for Data Storage
resource "aws_s3_bucket" "reddit_bucket" {
    bucket = var.s3_bucket
    force_destroy = true
}

# The ACL resource block is omitted to avoid issues with buckets that do not support ACLs
