output "resource_group_name" {
    value = azurerm_resource_group.rg.name
}

output "vm_public_ip" {
    value = azurerm_linux_virtual_machine.MainVM.public_ip_address
}
