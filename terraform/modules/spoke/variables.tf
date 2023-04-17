
variable "location" {
  type = object({
    name  = string
    short = string
    mini  = string
  })
}

variable "workload" {
  type = string
}

variable "hub_vnet_id" {
  type = string
}

variable "private_dns_zone_id" {
  type = string
}

variable "private_dns_zone_name" {
  type = string
}

variable "private_dns_zone_resource_group_name" {
  type = string
}