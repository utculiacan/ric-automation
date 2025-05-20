terraform {
  required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      # LINK https://github.com/Telmate/terraform-provider-proxmox
      source = "telmate/proxmox"
      version = "3.0.1-rc9"
    }
  }
}

#Should match the names on credentials.auto.tfvars file
#ie: PROXMOX_URL = "https://192.168.XXX.X:8006/api2/json"
variable "PROXMOX_URL" {
  type = string
}

variable "PROXMOX_USER" {
  type      = string
  sensitive = true
}

variable "PROXMOX_TOKEN" {
  type      = string
  sensitive = true
}

provider "proxmox" {
  pm_api_url = var.PROXMOX_URL
  pm_api_token_id = var.PROXMOX_USER
  pm_api_token_secret = var.PROXMOX_TOKEN
  
  # NOTE Optional, but recommended to set to true if you are using self-signed certificates.
  pm_tls_insecure = true
}
