terraform {
  required_version = ">= 1.2.0"

  required_providers {
    ansible = {
      source  = "ansible/ansible"
      version = "1.4.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.9.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.3.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}
