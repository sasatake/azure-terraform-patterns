variable "main_region" {
  type    = string
  default = "japaneast"
}

variable "virtual_network_address_spaces" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
