variable "stage_name" {
}

module environment {
  source = "../../modules/environment"
}

locals {
  otc_domain_name = "OTC-EU-DE-00000000001000055571"
  otc_tenant_name = "eu-de_showcase" # This is the tenant or a project name (project = sub-tenant)
}