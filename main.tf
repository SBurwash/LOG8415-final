resource "azurerm_resource_group" "rg" {
  name      = "discord_log8415_project"
  location  = "eastus"
}

resource "azurerm_virtual_network" "MainNetwork" {
    name                = "MainNetwork"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "MainSubnet" {
    name                    = "subnet"
    virtual_network_name    = azurerm_virtual_network.MainNetwork.name
    resource_group_name     = azurerm_resource_group.rg.name
    address_prefixes        = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "MainPublicIP" {
    name                = "public_ip"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method    = "Dynamic"
}

resource "azurerm_network_security_group" "MainSecurityGroup" {
    name = "security_group"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_network_interface" "MainNetworkInterface" {
    name = "network_interface"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "nic_ip_config"
        subnet_id                     = azurerm_subnet.MainSubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.MainPublicIP.id
    }
}

resource "azurerm_network_interface_security_group_association" "MainNetworkInterfaceSecurityGroupAssociation" {
    network_interface_id      = azurerm_network_interface.MainNetworkInterface.id
    network_security_group_id = azurerm_network_security_group.MainSecurityGroup.id
} 

resource "azurerm_storage_account" "MainStorageAccount" {
    name                        = "cloudfinalprojectstorage"
    resource_group_name         = azurerm_resource_group.rg.name
    location                    = azurerm_resource_group.rg.location
    account_tier                = "Standard"
    account_replication_type    = "LRS"
}

resource "azurerm_ssh_public_key" "SSHKey" {
  name                = "SSHKey"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  public_key          = file(var.SSHPubKey)
}

resource "azurerm_linux_virtual_machine" "MainVM" {
    name                  = "lo8415_vm"
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.MainNetworkInterface.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "VM"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "azureuser"
        public_key     = azurerm_ssh_public_key.SSHKey.public_key
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.MainStorageAccount.primary_blob_endpoint
    }
}

# resource "azurerm_virtual_machine_extension" "MainVMExt" {
#     name                    = "MainVMExt"
#     virtual_machine_id   = azurerm_linux_virtual_machine.MainVM.id
#     publisher            = "Microsoft.Azure.Extensions"
#     type                 = "CustomScript"
#     type_handler_version = "2.0"

#     protected_settings = <<PROT
#     {
#         "script": "${base64encode(file(var.execute_script))}"
#     }
#     PROT
# }

