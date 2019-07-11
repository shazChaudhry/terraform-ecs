module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"

  name = "${var.cluster-name}-cluster-sg"
  description = "${var.cluster-name} cluster SG"
  vpc_id      = "${module.vpc.vpc_id}"

  tags = {
    Name = "${var.cluster-name}-cluster-sg"
  }
}
