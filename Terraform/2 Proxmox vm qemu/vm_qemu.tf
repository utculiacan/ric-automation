#Should match the names on credentials.auto.tfvars file
#ie: PUBLIC_SSH_KEY = "ssh-rsa SUPERSECRETKEY user@host"
variable "PUBLIC_SSH_KEY" {
  type      = string
  sensitive = true
}

resource "proxmox_vm_qemu" "your-vm" {

  # SECTION General Settings

  name = "clon-debian12.8-terraform"
  desc = "Created from terraform"
  agent = 1  # <-- (Optional) Enable QEMU Guest Agent

  # FIXME Before deployment, set the correct target node name
  target_node = "pve2"

  # FIXME Before deployment, set the desired VM ID (must be unique on the target node)
  vmid = "5051"

  # !SECTION
  
  # SECTION Template Settings

  # FIXME Before deployment, set the correct template or VM name in the clone field
  #       or set full_clone to false, and remote "clone" to manage existing (imported) VMs
  clone = "debian12.8-cloud"
  full_clone = true

  # !SECTION

  # SECTION Boot Process

  onboot = false

  # NOTE Change startup, shutdown and auto reboot behavior
  startup = ""
  automatic_reboot = false

  # !SECTION

  # SECTION Hardware Settings

  qemu_os = "l26"
  bios = "seabios"
  cores = 2
  sockets = 1
  cpu_type = "x86-64-v2-AES"
  memory = 2048

  # NOTE Minimum memory of the balloon device, set to 0 to disable ballooning
  balloon = 2048
  
  #Display
  vga {
    type   = "std"
    #Between 4 and 512, ignored if type is defined to serial
    #memory = 4
  }

  # !SECTION

  # SECTION Network Settings

  network {
    id     = 0  # NOTE Required since 3.x.x
    bridge = "vmbr0"
    model  = "virtio"
  }

  # !SECTION

  # SECTION Disk Settings
  boot = "order=scsi0;net0"
  # NOTE Change the SCSI controller type, since Proxmox 7.3, virtio-scsi-single is the default one         
  scsihw = "virtio-scsi-pci"
  
  # NOTE New disk layout (changed in 3.x.x)
  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"

          # NOTE Since 3.x.x size change disk size will trigger a disk resize
          size = "2G"

          # NOTE Enable IOThread for better disk performance in virtio-scsi-single
          #      and enable disk replication
          #iothread = true
          #replicate = false
        }
      }
    }
  }

  # !SECTION

  # SECTION Cloud Init Settings

  # FIXME Before deployment, adjust according to your network configuration
  ipconfig0 = "ip=dhcp"
  nameserver = "192.168.1.1"
  ciuser = "" #Cloud init user
  cipassword = "" #Cloud init password
  sshkeys = var.PUBLIC_SSH_KEY

  # !SECTION
}
