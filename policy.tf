resource "aws_iam_role" "urbackup" {
  name = "urbackup-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
  tags = {
    tag-key = "urbackup-s3-bucket-access"
  }
}

resource "aws_iam_instance_profile" "urbackup" {
  name = "urbackup"
  role = aws_iam_role.urbackup.name

}


resource "aws_iam_policy" "urbackup" {
  name = "urbackup-policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:DeleteObject",
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "arn:aws:s3:::urbackup/*",
                "arn:aws:s3:::urbackup"
            ]
        }
    ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "urbackup" {
  role       = aws_iam_role.urbackup.name
  policy_arn = aws_iam_policy.urbackup.arn
}


