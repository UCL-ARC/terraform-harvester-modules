terraform {
  required_version = ">= 1.2.0"

  required_providers {
    ansible = {
      source  = "ansible/ansible"
      version = "1.3.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}
