terraform {
  required_version = ">= 1.2.0"

  required_providers {
    ansible = {
      source  = "ansible/ansible"
      version = "1.3.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.6.2"
    }
  }
}
