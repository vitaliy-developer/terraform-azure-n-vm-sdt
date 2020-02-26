# location

variable "location" {
  description = "variable for location"
}

variable "prefix" {
    type = string
    default = "my"
}

variable "tags" {
    type = map

    default = {
        Environment = "Terraform GS"
        Dept = "Engineering"
  }
}

variable "sku" {
    default = {
        # westus = "16.04-LTS"
        eastus = "18.04-LTS"
    }
}

variable "public_ip_address_allocation" {
  description = "This attribute is deprecated, and to be replaced by 'allocation_method'"
  default     = ""
}

variable "allocation_method" {
  description = "Defines how an IP address is assigned. Options are Static or Dynamic."
  default     = ""
}


variable "name" {

}


# variable "security_group" {
#    type = list(object({
#         name                       = number
#         priority                   = number
#         direction                  = string
#         access                     = string
#         protocol                   = string
#         source_port_range          = number
#         destination_port_range     = number
#         source_address_prefix      = number
#         destination_address_prefix = number
#   }))
#    default = [
#     {
#         name                       = "SSH",
#         priority                   = 1001,
#         direction                  = "Inbound",
#         access                     = "Allow",
#         protocol                   = "Tcp",
#         source_port_range          = "*",
#         destination_port_range     = 22,
#         source_address_prefix      = "*",
#         destination_address_prefix = "*"
#     }
#    ]
# }

variable "security_group" {

}



variable "secondary_disks" {

}

variable "vm_count" {

}
# os_profile
variable "computer_name" {

}
variable "admin_username" {

}
variable "admin_password" {

}
variable "disable_password_authentication" {

}
# other variebles

variable "tags_linux_config" {

}
variable "storage_image_reference_publisher" {
  
}

variable "storage_image_reference_offer" {
  
}

variable "storage_image_reference_sku" {
  
}

variable "storage_image_reference_version" {
  
}
variable "storage_os_disk_name" {
  
}
variable "storage_os_disk_caching" {
  
}
variable "storage_os_disk_create_option" {
  
}
variable "storage_os_disk_managed_disk_type" {
  
}
variable "azurerm_virtual_machine_vm_size" {
  
}
variable "nic_private_ip_address_allocation" {
  
}
variable "azurerm_subnet_address_prefix" {
  
}
variable "azurerm_virtual_network_address_space" {
  
}
