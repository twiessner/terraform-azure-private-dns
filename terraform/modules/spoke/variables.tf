
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

variable "private_dns_zone_id" {
  type = string
}

variable "private_dns_zone_name" {
  type = string
}