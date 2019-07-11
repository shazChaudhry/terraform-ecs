# # ecs ec2 role
# resource "aws_iam_role" "ecs_ec2_role" {
#   name = "ecs-ec2-role"
#
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# }
#
# resource "aws_iam_role_policy" "ecs_ec2_role_policy" {
#   name = "ecs-ec2_role-policy"
#   role = "${aws_iam_role.ecs_ec2_role.id}"
#
#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#               "ecs:CreateCluster",
#               "ecs:DeregisterContainerInstance",
#               "ecs:DiscoverPollEndpoint",
#               "ecs:Poll",
#               "ecs:RegisterContainerInstance",
#               "ecs:StartTelemetrySession",
#               "ecs:Submit*",
#               "ecs:StartTask",
#               "ecr:GetAuthorizationToken",
#               "ecr:BatchCheckLayerAvailability",
#               "ecr:GetDownloadUrlForLayer",
#               "ecr:BatchGetImage",
#               "logs:CreateLogStream",
#               "logs:PutLogEvents"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "logs:CreateLogGroup",
#                 "logs:CreateLogStream",
#                 "logs:PutLogEvents",
#                 "logs:DescribeLogStreams"
#             ],
#             "Resource": [
#                 "arn:aws:logs:*:*:*"
#             ]
#         }
#     ]
# }
# EOF
# }
#
# resource "aws_iam_instance_profile" "ecs_ec2_role" {
#   name = "ecs-ec2-role"
#   role = "${aws_iam_role.ecs_ec2_role.name}"
# }
#
# # ecs service role
# resource "aws_iam_role" "ecs_service_role" {
#   name = "ecs-service-role"
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
# resource "aws_iam_role_policy_attachment" "ecs-service-attach" {
#   role = "${aws_iam_role.ecs_service_role.name}"
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
# }
