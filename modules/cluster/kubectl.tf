locals {
  client_key_data         = opentelekomcloud_cce_cluster_v3.cluster.certificate_users[0].client_key_data
  client_certificate_data = opentelekomcloud_cce_cluster_v3.cluster.certificate_users[0].client_certificate_data
  kubectl_external_server = opentelekomcloud_cce_cluster_v3.cluster.certificate_clusters[1].server
  cluster_certificate_authority_data = opentelekomcloud_cce_cluster_v3.cluster.certificate_clusters[1].certificate_authority_data
}



locals {
  kubectl_config = yamlencode({
    apiVersion = "v1"
    clusters = [
      {
        cluster = {
          insecure-skip-tls-verify = true
          server                   = local.kubectl_external_server
        }
        name = "externalCluster-${var.stage_name}"
      },
    ]
    contexts = [
      {
        context = {
          cluster = "externalCluster-${var.stage_name}"
          user    = "terraform"
        }
        name = var.stage_name
      },
    ]
    current-context = var.stage_name
    kind            = "Config"
    preferences     = {}
    users = [
      {
        name = "terraform"
        user = {
          client-certificate-data = local.client_certificate_data
          client-key-data         = local.client_key_data
        }
      },
    ]
  })
}

resource "opentelekomcloud_s3_bucket" "kubeconfig" {
  bucket   = "kubeconfig-otc-customer-success-${var.stage_name}"
  acl      = "private"
  region   = "eu-de"
  versioning {
    enabled = true
  }
}

resource "opentelekomcloud_s3_bucket_object" "kubeconfig" {
  bucket = opentelekomcloud_s3_bucket.kubeconfig.bucket
  key    = "config"
  content = local.kubectl_config
  etag   = md5(local.kubectl_config)
}

output "kubectl_config" {
  value = local.kubectl_config
}

output "kubernetes_host" {
  value = local.kubectl_external_server
}

output "kubernetes_ca_cert" {
  value = base64decode(local.cluster_certificate_authority_data)
}