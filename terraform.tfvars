# location
location = "eastus"

# os_profile
computer_name  = "hostname"
admin_username = "plankton"
admin_password = "Password1234!"

# Create virtual network, subnet
name = "virtual"

# os profile linux config
disable_password_authentication = "false"

#storage_image_reference
storage_image_reference_publisher = "Canonical"
storage_image_reference_offer = "UbuntuServer"
storage_image_reference_sku = "16.04-LTS"
storage_image_reference_version = "latest"

# storage_os_disk
storage_os_disk_name = "my_os_disk"
storage_os_disk_caching = "ReadWrite"
storage_os_disk_create_option = "FromImage"
storage_os_disk_managed_disk_type = "Standard_LRS"

# azurerm_virtual_machine
azurerm_virtual_machine_vm_size = "Standard_DS1_v2"

# quantity linux virtual machine and network interface
vm_count = 3

# azurerm_network_interface
nic_private_ip_address_allocation = "dynamic"

# azurerm_subnet
azurerm_subnet_address_prefix = "10.0.1.0/24"

# azurerm_virtual_network ##

azurerm_virtual_network_address_space = ["10.0.0.0/16"]

# security_rule
security_group = {
        name                       = "SSH",
        priority                   = 1001,
        direction                  = "Inbound",
        access                     = "Allow",
        protocol                   = "Tcp",
        source_port_range          = "*",
        destination_port_range     = "22",
        source_address_prefix      = "*",
        destination_address_prefix = "*"
    }
# array disk
secondary_disks = [
 {
    name = "disk_1"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "10"
 },
 {
    name = "disk_2"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 1
    disk_size_gb      = "20"
 },
 {
    name = "disk_3"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 2
    disk_size_gb      = "30"
 },
 {
    name = "disk_4"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 3
    disk_size_gb      = "10"
 }
]

# other
prefix = "group"
tags_linux_config   = "staging"