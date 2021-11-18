module environment {
  source = "../../modules/environment"
}

locals {
  stage_name            = "showcase"
  vpc_cidr              = "192.168.0.0/16"
  vpc_subnet_gateway_ip = "192.168.0.1"
  node_spec_default     = "s3.large.4"
  dns_zone_id = "ff80808275f5fc0f017868e827db3755"
  otc_domain_name = "OTC-EU-DE-00000000001000055571"
  otc_tenant_name = "eu-de_showcase" # This is the tenant or a project name (project = sub-tenant)
  node_spec = {
    1 = local.node_spec_default
    2 = local.node_spec_default
  }
}