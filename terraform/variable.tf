variable "db_password" {
  description = "Password for Redshift master DB user"
  type        = string
  default     = "h9!L*31rs02"
}

variable "s3_bucket" {
  description = "Bucket name for S3"
  type        = string
  default     = "reddit-bucket-unique-20240208"
}

variable "aws_region" {
  description = "Region for AWS"
  type        = string
  default     = "eu-north-1"
}

variable "iam_role_name" {
  description = "IAM role name for Redshift to access S3"
  type        = string
  default     = "RedShiftLoadRole-Unique-20240208"
}

variable "security_group_name" {
  description = "Name for the Redshift security group"
  type        = string
  default     = "redshift-sg-unique-20240208"  // Updated to not start with "sg-"
}

