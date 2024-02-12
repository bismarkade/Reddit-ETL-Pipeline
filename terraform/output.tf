# Output hostname of Redshift
output "redshift_cluster_hostname" {
  description = "Hostname of the Redshift instance"
  value       = replace(
      aws_redshift_cluster.redshift.endpoint,
      format(":%s", aws_redshift_cluster.redshift.port),"",
  )
}

# Output port of Redshift
output "redshift_port" {
    description = "Port of the Redshift cluster"
    value = aws_redshift_cluster.redshift.port
}

# Output Redshift password
output "redshift_password" {
    description = "Password of the Redshift cluster"
    value = var.db_password
}

# Output Redshift username
output "redshift_username" {
    description = "Username of the Redshift cluster"
    value = aws_redshift_cluster.redshift.master_username
}

# Output Role assigned to Redshift
output "redshift_role" {
    description = "IAM Role name assigned to the Redshift cluster"
    value = aws_iam_role.redshift_role.name
}

# Output Account ID of AWS
data "aws_caller_identity" "current" {}
output "account_id" {
  description = "AWS Account ID"
  value = data.aws_caller_identity.current.account_id
}

# Output Region set for AWS
output "aws_region" {
    description = "AWS Region where resources are deployed"
    value = var.aws_region
}

# Output S3 bucket name
output "s3_bucket_name" {
    description = "Name of the S3 bucket"
    value = var.s3_bucket
}
