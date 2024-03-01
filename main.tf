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

resource "huaweicloud_vpc" "myvpc" {
  name = "terraform_vpc"
  cidr = "192.168.0.0/16"
}
resource "huaweicloud_vpc" "myvpct" {
  name = "terraform_vpc"
  cidr = "192.169.0.0/16"
}
# An example resource that does nothing.
resource "null_resource" "example" {
    triggers = {
    value = "A example resource that does nothing!"
    }
}
