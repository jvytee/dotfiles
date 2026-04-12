variable "passphrase" {
  type        = string
  sensitive   = true
  description = "Passphrase for state file encryption"
}

variable "hcloud_api_token" {
  type        = string
  sensitive   = true
  description = "API token for Hetzner Cloud"
}

variable "inwx_username" {
  type        = string
  sensitive   = true
  description = "INWX username"
}

variable "inwx_password" {
  type        = string
  sensitive   = true
  description = "INWX password"
}
