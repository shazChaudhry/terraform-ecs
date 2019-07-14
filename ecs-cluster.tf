resource "aws_ecs_cluster" "ecs" {
  name = "${var.cluster-name}"
}

module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"
  name   = "${var.cluster-name}"

  # Launch configuration
  lc_name              = "-lc"
  iam_instance_profile = "${aws_iam_instance_profile.asg_profile.id}"
  image_id             = "${data.aws_ami.latest_ecs.id}"
  instance_type        = "t2.medium"
  key_name             = "personal"
  security_groups      = ["${module.security_group.this_security_group_id}"]

  # Auto scaling group
  asg_name            = "-asg"
  vpc_zone_identifier = "${module.vpc.public_subnets}"
  health_check_type   = "EC2"
  min_size            = 1
  max_size            = 5
  desired_capacity    = 3
  user_data           = <<-EOF
                        #!/bin/bash
                        echo ECS_CLUSTER=${var.cluster-name} >> /etc/ecs/ecs.config
                        EOF
  wait_for_capacity_timeout = 0

  tags = [
    {
      key = "Environment"
      value = "${var.cluster-name}"
      propagate_at_launch = true
    },
  ]
}

# resource "aws_autoscaling_policy" "aws_autoscaling_policy" {
#   name = "${var.cluster-name}-autoscaling-policy"
#   policy_type = "TargetTrackingScaling"
#   estimated_instance_warmup = "90"
#   adjustment_type = "ChangeInCapacity"
#   autoscaling_group_name = "${module.asg.this_autoscaling_group_name}"
#
#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#
#     target_value = 80.0
#   }
# }
