resource "aws_iam_instance_profile" "asg_profile" {
  name_prefix = "${var.cluster-name}-profile-"
  role        = "${aws_iam_role.asg_role.name}"
}

resource "aws_iam_role" "asg_role" {
  name_prefix = "${var.cluster-name}-asg-role-"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Sid": ""
        }
    ]
}
EOF
}

# Policy needed on all asg instances for ssh authentication
resource "aws_iam_role_policy" "asg_policy" {
  name_prefix = "${var.cluster-name}-asg-policy-"
  role = "${aws_iam_role.asg_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeTags",
        "ec2:AttachVolume",
        "ec2:DescribeVolumes",
        "ec2:DescribeNetworkInterfaces",
        "ec2:AttachNetworkInterface"
      ],
      "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
          "ecs:CreateCluster",
          "ecs:DeregisterContainerInstance",
          "ecs:DiscoverPollEndpoint",
          "ecs:Poll",
          "ecs:RegisterContainerInstance",
          "ecs:StartTelemetrySession",
          "ecs:Submit*",
          "ecs:StartTask"
        ],
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:DescribeLogStreams",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ],
        "Resource": [
            "arn:aws:logs:*:*:*"
        ]
    }
  ]
}
EOF
}

# # ecs service role
# resource "aws_iam_role" "ecs_service_role" {
#   name = "${var.cluster-name}-service-role"
#
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ecs.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# }
#
# resource "aws_iam_role_policy_attachment" "ecs_service_attach" {
#   role = "${aws_iam_role.ecs_service_role.name}"
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
# }
