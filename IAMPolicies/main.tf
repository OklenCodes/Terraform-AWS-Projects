
resource "aws_s3_bucket" "log_bucket" {  #Note that S3 bucket names must be globally unique amongst all AWS customers.
  bucket = "oklen-extremely-unique"
    tags = {
      Name        = "MyBucketLog"
      Environment = "Production"
    }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.log_bucket.id
  policy = jsonencode(
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::498543162511:user/tester"
            },
            "Action": [
                "s3:ListBucket",
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::oklen-extremely-unique",
                "arn:aws:s3:::oklen-extremely-unique/*"
            ]
        }
    ]
    
  })
}

/*
resource "aws_iam_user_policy" "aws_s3_bucket" {
  name = "s3BucketPolicy"
  user = "tester"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
*/
resource "aws_iam_user" "user" {
  name = "tester"
  path = "/"
}
