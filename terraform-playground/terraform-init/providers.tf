provider "opentelekomcloud" {
  auth_url    = "https://iam.eu-de.otc.t-systems.com/v3"
  access_key  = module.environment.variable["ACCESS_KEY"]
  secret_key  = module.environment.variable["SECRET_KEY"]
  # The Name of the Tenant (Identity v2) or Project (Identity v3) to login with. If omitted, the OS_TENANT_NAME or OS_PROJECT_NAME environment variable are used.
  domain_name = local.otc_domain_name
  tenant_name = local.otc_tenant_name
}