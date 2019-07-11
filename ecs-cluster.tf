# ECS cluster
resource "aws_ecs_cluster" "ecs" {
  name = "${var.cluster-name}"
}

module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"
  name = "${var.cluster-name}"

  # Launch configuration
  lc_name = "-lc"
  # Need to create a role
  iam_instance_profile = "shaz"
  image_id        = "${data.aws_ami.latest_ecs.id}"
  instance_type   = "t2.small"
  key_name        = "personal"
  security_groups = ["${module.security_group.this_security_group_id}"]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "-asg"
  vpc_zone_identifier       = "${module.vpc.private_subnets}"
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  user_data                 = <<-EOF
                              #!/bin/bash
                              echo ECS_CLUSTER=${var.cluster-name} >> /etc/ecs/ecs.config
                              EOF
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "ECS"
      propagate_at_launch = true
    },
  ]
}

resource "aws_autoscaling_policy" "ecs_cluster" {
  name                      = "ecs-auto-scaling"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = "90"
  adjustment_type           = "ChangeInCapacity"
  autoscaling_group_name    = "${module.asg.this_autoscaling_group_name}"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40.0
  }
}
