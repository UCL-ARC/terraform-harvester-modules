terraform {
  required_version = ">= 1.2.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}
