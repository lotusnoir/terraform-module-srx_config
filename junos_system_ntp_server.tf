##################################################################################
variable "ntp_server" {
  type = list(object({
    address          = string
    key              = optional(number)
    prefer           = optional(bool)
    routing_instance = optional(string)
    version          = optional(number)
  }))
  default = []
}

resource "junos_system_ntp_server" "this" {
  for_each = var.ntp_server != null ? { for k, v in var.ntp_server : v.address => v } : {}

  address          = each.value.address
  key              = each.value.key
  prefer           = each.value.prefer
  routing_instance = each.value.routing_instance
  version          = each.value.version
}
