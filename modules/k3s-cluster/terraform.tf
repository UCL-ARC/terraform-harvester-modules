terraform {
  required_version = ">= 1.2.0"

  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = ">= 1.6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.3.0"
    }
  }
}
