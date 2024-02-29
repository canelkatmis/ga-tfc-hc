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
      version = ">= 2.3.0"
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

resource "hcs_vpc_subnet" "mysubnet" {
  name       = "subnet"
  cidr       = "192.168.0.0/24"
  gateway_ip = "192.168.0.1"

  //dns is required for cce node installing
  primary_dns   = "100.125.1.250"
  secondary_dns = "100.125.21.250"
  vpc_id        = hcs_vpc.myvpc.id
}

resource "hcs_cce_cluster" "cluster" {
  name                   = "cluster"
  flavor_id              = "cce.s1.small"
  vpc_id                 = hcs_vpc.myvpc.id
  subnet_id              = hcs_vpc_subnet.mysubnet.id
  container_network_type = "overlay_l2"
}

# An example resource that does nothing.
resource "null_resource" "example" {
    triggers = {
    value = "A example resource that does nothing!"
    }
}
