terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.60.1"
    }
    inwx = {
      source = "inwx/inwx"
      version = "1.6.4"
    }
  }
}

provider "hcloud" {
  # TODO Configuration options
}

provider "inwx" {
  # TODO Configuration options
}
