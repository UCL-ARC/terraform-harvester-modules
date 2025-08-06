terraform {
  required_version = ">= 1.2.0"

  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = "0.6.7"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.5.3"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
  }
}

provider "harvester" {
}
