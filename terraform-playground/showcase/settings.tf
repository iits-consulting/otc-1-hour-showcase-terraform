terraform {
  required_version = "v0.14.8"
  backend "s3" {
    key                         = "tfstate"
    bucket                      = "tfstate-showcase-state"
    region                      = "eu-de"
    endpoint                    = "obs.eu-de.otc.t-systems.com"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "~> 1.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = "1.23.7"
    }
  }
}