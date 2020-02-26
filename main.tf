# Configure the Microsoft Azure Provider.
provider "azurerm" {
   features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
    name     = "${var.prefix}azurerg"
    location = var.location
    tags     = var.tags
}

# Create virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = "${var.name}-vnet"
    address_space       = var.azurerm_virtual_network_address_space
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    tags                = var.tags
}

# Create subnet
resource "azurerm_subnet" "subnet" {
    name                 = "${var.name}-subnet"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefix       = var.azurerm_subnet_address_prefix
}

# # Create public IP
resource "azurerm_public_ip" "publicip" {
    count                        = var.vm_count
    name                         = "${var.prefix}-PublicIP-${count.index}"
    location                     = var.location
    resource_group_name          = azurerm_resource_group.rg.name
    # allocation_method            = "Dynamic"
    allocation_method            = coalesce(var.allocation_method, var.public_ip_address_allocation, "Dynamic")
    tags                         = var.tags
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
    name                = "${var.prefix}netwsecurgroup"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    tags                = var.tags
    security_rule  {
        name                       = var.security_group["name"]
        priority                   = var.security_group["priority"]
        direction                  = var.security_group["direction"]
        access                     = var.security_group["access"]
        protocol                   = var.security_group["protocol"]
        source_port_range          = var.security_group["source_port_range"]
        destination_port_range     = var.security_group["destination_port_range"]
        source_address_prefix      = var.security_group["source_address_prefix"]
        destination_address_prefix = var.security_group["destination_address_prefix"]
    }
}

# Create network interface
resource "azurerm_network_interface" "nic" {
    count                     = var.vm_count
    name                      = "nic-${var.prefix}-${count.index}"
    location                  = var.location
    resource_group_name       = azurerm_resource_group.rg.name
    tags                      = var.tags

    ip_configuration {
        name                          = "${var.prefix}-nic"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = var.nic_private_ip_address_allocation
        public_ip_address_id          = length(azurerm_public_ip.publicip.*.id) > 0 ? element(concat(azurerm_public_ip.publicip.*.id, list("")), count.index) : ""
    }
}

# Create a Linux virtual machine
resource "azurerm_virtual_machine" "vm" {
    count                 = var.vm_count
    name                  = "${var.prefix}virtual_machine${count.index}"
    location              = var.location
    resource_group_name   = azurerm_resource_group.rg.name
    # network_interface_ids = [azurerm_network_interface.nic.id]
    network_interface_ids = [element(azurerm_network_interface.nic.*.id, count.index)]
    vm_size               = var.azurerm_virtual_machine_vm_size
    # tags                  = var.tags

    storage_image_reference {
      publisher = var.storage_image_reference_publisher
      offer     = var.storage_image_reference_offer
      sku       = var.storage_image_reference_sku
      version   = var.storage_image_reference_version
    }
    storage_os_disk {
      name              = "${var.storage_os_disk_name}-${count.index}"
      caching           = var.storage_os_disk_caching
      create_option     = var.storage_os_disk_create_option
      managed_disk_type = var.storage_os_disk_managed_disk_type
    }

    dynamic "storage_data_disk" {
      for_each = var.secondary_disks
      content {
        name              = "${storage_data_disk.value["name"]}-${count.index}"
        managed_disk_type = storage_data_disk.value["managed_disk_type"]
        create_option     = storage_data_disk.value["create_option"]
        lun               = storage_data_disk.value["lun"]
        disk_size_gb      = storage_data_disk.value["disk_size_gb"]
      }
    }
    os_profile {
      computer_name  = var.computer_name
      admin_username = var.admin_username
      admin_password = var.admin_password
    }
    os_profile_linux_config {
      disable_password_authentication = var.disable_password_authentication
    }
    tags = {
      environment = var.tags_linux_config
    }

}

# output "ip" {
#     value = azurerm_public_ip.publicip.ip_address
# }

# output "os_sku" {
#     value = lookup(var.sku, var.location)
# }