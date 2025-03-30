resource "aws_iam_user" "terraform_cicd_user" {
  name = "terraform-cicd-user"
}

resource "aws_iam_access_key" "terraform_cicd_user_key" {
  user = aws_iam_user.terraform_cicd_user.name
}

resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = aws_iam_user.terraform_cicd_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_policy" "cross_account_s3" {
  name = "cross-account-s3-access"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:GetBucketLocation"
        ]
        Resource = [
          "arn:aws:s3:::${var.state_s3_bucket_name}",
          "arn:aws:s3:::${var.state_s3_bucket_name}/*"
        ]
      }
    ]
  })
}

# Attach the cross-account S3 policy to the user
resource "aws_iam_user_policy_attachment" "cross_account_s3_attachment" {
  user       = aws_iam_user.terraform_cicd_user.name
  policy_arn = aws_iam_policy.cross_account_s3.arn
}
