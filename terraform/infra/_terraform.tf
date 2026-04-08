terraform {

  backend "oci" {
    namespace = "axiyuxi1vimf"
    bucket    = "terraform-states"
    key       = "infra/cluster.tfstate"
  }

  required_providers {
    jq = {
      source  = "massdriver-cloud/jq"
      version = "0.2.1"
    }
    oci = {
      source  = "oracle/oci"
      version = "~> 7.32.0"
    }
  }
}
