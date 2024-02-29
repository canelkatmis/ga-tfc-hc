terraform {
  backend "remote" {
    organization = "canelkatmis"
    workspaces {
        name = "hc-test"
    }
  }
  required_providers {
    huaweicloud = {
      source = "huaweicloud/huaweicloud"
      version = ">= 1.20.0"
    }
  }
}

provider "huaweicloud" {
  region     = "ap-southeast-3"
}

# An example resource that does nothing.
resource "null_resource" "example" {
    triggers = {
    value = "A example resource that does nothing!"
    }
}
