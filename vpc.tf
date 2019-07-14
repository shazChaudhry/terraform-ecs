module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  enable_dns_hostnames             = true
  enable_dns_support               = true
  enable_nat_gateway               = true
  map_public_ip_on_launch          = true
  enable_dhcp_options              = true
  single_nat_gateway               = true
  cidr                             = "10.0.0.0/25"
  azs                              = "${data.aws_availability_zones.all.names}"
  private_subnets                  = ["10.0.0.0/27", "10.0.0.32/27"]  # AZ a and b
  public_subnets                   = ["10.0.0.64/27", "10.0.0.96/27"] # AZ a and b
  dhcp_options_domain_name         = "domain.internal"
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  dhcp_options_tags = {
    Name = "${var.cluster-name}-dhcp"
  }

  vpc_tags = {
    Name = "${var.cluster-name}-vpc"
  }

  public_subnet_tags = {
    Name = "${var.cluster-name}-public_subnets"
  }

  public_route_table_tags = {
    Name = "${var.cluster-name}-public_route_table"
  }

  private_subnet_tags = {
    Name = "${var.cluster-name}-private_subnet"
  }

  private_route_table_tags = {
    Name = "${var.cluster-name}-private_route_table"
  }

  nat_gateway_tags = {
    Name = "${var.cluster-name}-nat_gateway"
  }

  nat_eip_tags = {
    Name = "${var.cluster-name}-nat_eip"
  }

  igw_tags = {
    Name = "${var.cluster-name}-igw"
  }

  tags = {
    Environment = "${var.cluster-name}"
    Terraform   = "true"
  }
}
