variable "aws_region" {
  description = "storing of region from aws console"
  default     = "us-east-2"
}

variable "s3_bucket_name" {
  type = string
  default = "mahira-s3-bucket"
}

variable "user_name" {
  type = string
  default = "mahira_user"
}
