output "bucket_arn" {
  value = aws_s3_bucket.mahira.arn
}

output "bucket_acl" {
  value = aws_s3_bucket.mahira.acl
}

output "user_id" {
  value = aws_iam_user.mahira-user.id
}
