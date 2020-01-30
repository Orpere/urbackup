output "this_s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.urbackup.arn
}

output "role_name" {
  value = aws_iam_role.urbackup.name
}

output "role_policy" {
  value = aws_iam_policy.urbackup.arn
}

output "role_profile" {
  value = aws_iam_instance_profile.urbackup.name
}

output "urbackup_server_ips" {
  value = [aws_instance.urbackup_server.public_ip]
}

output "urbackup_server_dns" {
  value = [aws_instance.urbackup_server.public_dns]
}