resource "vault_generic_secret" "elb_info" {
  path = "secret/${var.stage_name}/elb_info"
  disable_read = false
  data_json = jsonencode({
    elb_id = var.elb_id
  })
}

resource "vault_generic_secret" "kubectl" {
  path = "secret/${var.stage_name}/kubectl"
  disable_read = false
  data_json = jsonencode({
    kubectl_config = var.kubectl_config
  })
}