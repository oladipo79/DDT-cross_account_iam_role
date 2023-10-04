  resource "aws_iam_role" "cross_account_iam_role" {
  name = "cross_account_iam_role"
   assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = var.Effect_Role
            Sid    = ""            
            Principal = {
                Service = "ec2.amazonaws.com"
            },
            Action = "sts:AssumeRole"
                }
      ,
    ]
  })
  

  tags = {
    tag-key = "cross_iam_role"
  }
}


resource "aws_iam_policy" "cross_account_iam_policy" {
  name = "cross_account_iam_policy"
  #role = aws_iam_role.cross_account_iam_role.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
      {
        Action = var.Action
        Effect = var.Effect_Policy 
        Resource = "*"
      },
    ]
  })

}

resource "aws_iam_policy_attachment" "cross_account_iam_policy_attachment" {
  name = "cross_account_iam_policy"
  policy_arn = aws_iam_policy.cross_account_iam_policy.arn
  roles      = [aws_iam_role.cross_account_iam_role.name]
  }