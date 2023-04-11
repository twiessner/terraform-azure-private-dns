
variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "location" {
  type = object({
    name  = string
    short = string
    mini  = string
  })
  default = {
    name  = "westeurope"
    short = "westeu"
    mini  = "weu"
  }
}

variable "workload" {
  type    = string
  default = "private-dns"
}