terraform {
  required_version = ">= 1.2.0"

  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = ">= 0.6.6"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.6.2"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
  }
}
