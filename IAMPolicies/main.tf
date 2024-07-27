resource "aws_s3_bucket" "mahira" {
  bucket = var.s3_bucket_name
}
 
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.mahira.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "${aws_iam_user.mahira-user.name}"
        }
        Action = [
          "s3:*"
        ]
        Resource = [
          "${aws_s3_bucket.mahira.arn}/*",
          "${aws_s3_bucket.mahira.arn}"
        ]
      }
    ]
  })
}

resource "aws_iam_user" "user" {
  name = "test-user"
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy      = "{ ... policy JSON ... }"
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}
