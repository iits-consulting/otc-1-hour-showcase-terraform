locals {
  buckets = toset([
    "tfstate-${var.stage_name}-state"
  ])
}

resource "opentelekomcloud_s3_bucket" "tf_remote_states" {
  for_each = local.buckets
  bucket   = each.value
  acl      = "private"
  region   = "eu-de"
  versioning {
    enabled = true
  }
}