data "external" "environment_variables" {
  program = split(" ", "jq -n env")
}

output "variable" {
  sensitive = true
  value     = data.external.environment_variables.result
}

