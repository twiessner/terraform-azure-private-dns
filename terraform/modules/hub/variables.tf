
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