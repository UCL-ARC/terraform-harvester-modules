terraform {
  required_version = ">= 1.9.0"

  required_providers {
    ansible = {
      source  = "ansible/ansible"
      version = "1.3.0"
    }

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
