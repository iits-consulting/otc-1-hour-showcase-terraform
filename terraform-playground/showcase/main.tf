module "cloud_tracing_service" {
  source = "../../modules/cloud_tracing_service"
}

module "keypair" {
  source             = "../../modules/keypair"
  stage_name         = local.stage_name
}

module "vpc" {
  source                = "../../modules/vpc"
  vpc_cidr              = local.vpc_cidr
  vpc_name              = "vpc-otc-customer-success-${local.stage_name}"
  stage_name            = local.stage_name
  vpc_subnet_cidr       = local.vpc_cidr
  vpc_subnet_gateway_ip = local.vpc_subnet_gateway_ip
}

module "cluster" {
  source        = "../../modules/cluster"
  key_pair_id   = module.keypair.keypair_name
  stage_name    = local.stage_name
  subnet_id     = module.vpc.subnet_network_id
  vpc_flavor_id = "cce.s1.small"
  vpc_id        = module.vpc.vpc_id
  vpc_cidr      = local.vpc_cidr
  nodes         = local.node_spec
}

module "loadbalancer" {
  source     = "../../modules/loadbalancer"
  stage_name = local.stage_name
  subnet_id  = module.vpc.subnet_id
}

module "vault_terraform_secrets" {
  source = "../../modules/vault_terraform_secrets"
  stage_name = local.stage_name
  kubectl_config = base64encode(module.cluster.kubectl_config)
  elb_id = module.loadbalancer.elb_id
}

output "loadbalancer_eip" {
  value = module.loadbalancer.elb_public_ip
}