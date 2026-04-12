resource "hcloud_server" "hetzner01" {
  name         = "hetzner01"
  server_type  = "cx33"
  location     = "fsn1"
  image        = "debian-13"
  ssh_keys     = [hcloud_ssh_key.main.id]
  firewall_ids = [hcloud_firewall.hetzner01]

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

resource "hcloud_ssh_key" "main" {
  name       = "jvytee@posteo.org"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "hcloud_firewall" "hetzner01" {
  name = "hetzner01"
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}

resource "inwx_nameserver" "hochzeit" {
  domain = local.minevent_domain
  type   = "MASTER"
  nameservers = [
    "ns.inwx.de",
    "ns2.inwx.de",
    "ns3.inwx.eu"
  ]
}

resource "inwx_nameserver_record" "hochzeit_v4" {
  domain     = local.minevent_domain
  type       = "A"
  content    = hcloud_server.hetzner01.ipv4_address
  depends_on = [inwx_nameserver.hochzeit]
}

resource "inwx_nameserver_record" "hochzeit_v6" {
  domain     = local.minevent_domain
  type       = "AAAA"
  content    = hcloud_server.hetzner01.ipv6_address
  depends_on = [inwx_nameserver.hochzeit]
}
