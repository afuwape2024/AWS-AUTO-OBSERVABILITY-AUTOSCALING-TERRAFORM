module "network" {
  source = "./1vpc"
  cidr_block = var.cidr_block
  aws_vpc = var.aws_vpc
  aws_public_subnet_cidr = var.aws_public_subnet_cidr
  aws_private_subnet_cidr = var.aws_private_subnet_cidr
  aws_public_subnet_cidr_2 = var.aws_public_subnet_cidr_2
  aws_private_subnet_cidr_2 = var.aws_private_subnet_cidr_2
  aws_availability_zone_1 = var.aws_availability_zone_1
  aws_availability_zone_2 = var.aws_availability_zone_2

}

module "internet_gateway" {
  source = "./2internetgateway"
  tier2_vpc = module.network.tier2_vpc
}



module "routing" {
  source = "./3routetable"
  tier2_vpc = module.network.tier2_vpc
  ig_tier2 = module.internet_gateway.ig_tier2
    public_subnet = module.network.public_subnet1
    public_subnet2 = module.network.public_subnet2
    private_subnet = module.network.private_subnet1
    private_subnet2 = module.network.private_subnet2
}

module "security_nacl" {
  source = "./4nacl"
  tier2_vpc = module.network.tier2_vpc
  vpc_cidr_block = var.cidr_block
  ig_tier2 = module.internet_gateway.ig_tier2
  public_subnet = module.network.public_subnet1
  public_subnet2 = module.network.public_subnet2
  private_subnet = module.network.private_subnet1
  private_subnet2 = module.network.private_subnet2
}

module "security_group" {
  source = "./5security_group"
  tier2_vpc = module.network.tier2_vpc
  vpc_cidr_block = var.cidr_block
}

module "iam_prometheus" {
  source = "./9iam_prometheus"
  tier2_vpc = module.network.tier2_vpc
  vpc_cidr_block = var.cidr_block
  public_subnet = module.network.public_subnet1
  public_subnet2 = module.network.public_subnet2
  private_subnet = module.network.private_subnet1
  private_subnet2 = module.network.private_subnet2
  ig_tier2 = module.internet_gateway.ig_tier2
}

module "template_autoscaling" {
  source = "./7template_autoscaling"
  tier2_vpc = module.network.tier2_vpc
  ig_tier2 = module.internet_gateway.ig_tier2
  public_subnet = module.network.public_subnet1
  public_subnet2 = module.network.public_subnet2
  private_subnet = module.network.private_subnet1
  private_subnet2 = module.network.private_subnet2
  tier2_public_sg = module.security_group.tier2_public_sg
  key_pair_name = var.key_pair_name
  iam_instance_profile_name = module.iam_prometheus.prometheus_instance_profile
}

module "obs_instance" {
  source = "./obs_instance"
  tier2_vpc = module.network.tier2_vpc
  vpc_cidr_block = var.cidr_block
  public_subnet = module.network.public_subnet1
  tier2_public_sg = module.security_group.tier2_public_sg
  prometheus_sg = module.security_group.prometheus_sg
  grafana_sg = module.security_group.grafana_sg
  key_pair_name = var.key_pair_name
  iam_instance_profile_name = module.iam_prometheus.prometheus_instance_profile
  mandatory_tags = local.mandatory_tags
}