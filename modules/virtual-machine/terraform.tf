terraform {
  required_version = ">= 1.2.0"

  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = ">= 0.6.4"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.6.1"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
  }
}
