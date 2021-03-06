variable "resource_group_name_prefix" {
  default       = "rg"
  description   = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "resource_group_location" {
  default = "eastus"
  description   = "Location of the resource group."
}

variable "SSHPubKey" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}

variable "execute_script" {
  type = string
  default = "exec.bash"
}