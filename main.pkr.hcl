packer {
  required_plugins {
  digitalocean = {
    version = ">= 1.0.4"
    source  = "github.com/hashicorp/digitalocean"
    }
  }
}

variable "do_token" {
  type      = string
  sensitive = true
}

source "digitalocean" "bullseye" {
  api_token     = var.do_token
  droplet_agent = false
  image         = "debian-11-x64"
  monitoring    = false
  region        = "nyc1"
  size          = "s-1vcpu-512mb-10gb"
  ssh_username  = "root"
  snapshot_name = "marketplace-pi-hole-vpn-{{timestamp}}"
}

build {
  sources = [
    "source.digitalocean.bullseye"
  ]

  # Update the base image
  provisioner "shell" {
    scripts = [
      "scripts/system-setup.sh",
    ]
  }

  # Setup system on first boot after provisioning
  provisioner "file" {
    source      = "scripts/system-setup.sh"
    destination = "/tmp/"
  }
  provisioner "file" {
    source      = "scripts/ssh-unlock.sh"
    destination = "/tmp/"
  }
  provisioner "file" {
    source      = "scripts/reboot.sh"
    destination = "/tmp/"
  }
  provisioner "shell" {
    inline = [
      "mkdir -p                 /var/lib//cloud/scripts/per-instance/",
      "mv /tmp/system-setup.sh  /var/lib/cloud/scripts/per-instance/01-setup-system.sh",
      "chmod 700                /var/lib/cloud/scripts/per-instance/01-setup-system.sh",
      "mv /tmp/ssh-unlock.sh    /var/lib/cloud/scripts/per-instance/08-unlock-ssh.sh",
      "chmod 700                /var/lib/cloud/scripts/per-instance/08-unlock-ssh.sh",
      "mv /tmp/reboot.sh        /var/lib/cloud/scripts/per-instance/09-reboot.sh",
      "chmod 700                /var/lib/cloud/scripts/per-instance/09-reboot.sh"
    ]
  }

  # Setup OpenMPTCProuter on first boot after provisioning
  provisioner "file" {
    source      = "scripts/mptcp-setup.sh"
    destination = "/tmp/"
  }
  provisioner "shell" {
    inline = [
      "mkdir -p               /var/lib/cloud/scripts/per-instance/",
      "mv /tmp/mptcp-setup.sh /var/lib/cloud/scripts/per-instance/03-setup-mptcp.sh",
      "chmod 700 /var/lib/cloud/scripts/per-instance/03-setup-mptcp.sh",
    ]
  }

  # Cleanup the base image
  provisioner "shell" {
    scripts = [
      "scripts/image-cleanup.sh",
      "scripts/ssh-lock.sh",
      "scripts/image-check.sh"
    ]
  }
}
