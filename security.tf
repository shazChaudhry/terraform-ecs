module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.cluster-name}-cluster-sg"
  description = "${var.cluster-name} cluster SG"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]


  tags = {
    Name = "${var.cluster-name}-cluster-sg"
  }
}
