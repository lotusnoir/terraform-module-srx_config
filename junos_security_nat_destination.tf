##################################################################################
variable "nat_destination_pool" {
  type = map(object({
    address          = optional(string)
    address_port     = optional(number)
    address_to       = optional(string)
    description      = optional(string)
    routing_instance = optional(string)
  }))
  default = {}
}

resource "junos_security_nat_destination_pool" "this" {
  for_each = var.nat_destination_pool != null ? var.nat_destination_pool : {}

  name             = each.key
  address          = each.value.address
  address_port     = each.value.address_port
  address_to       = each.value.address_to
  description      = each.value.description
  routing_instance = each.value.routing_instance
}


##################################################################################
variable "nat_destination" {
  type = map(object({
    from = optional(object({
      type  = string
      value = set(string)
    }))

    rule = optional(list(object({
      name                     = string
      destination_address      = optional(string)
      destination_address_name = optional(string)
      application              = optional(set(string))
      destination_port         = optional(set(string))
      protocol                 = optional(set(string))
      source_address           = optional(set(string))
      source_address_name      = optional(set(string))
      then = optional(object({
        type = string
        pool = optional(string)
      }))
    })))

    description = optional(string)
  }))
  default = {}
}

resource "junos_security_nat_destination" "this" {
  for_each = var.nat_destination != null ? var.nat_destination : {}

  name = each.key

  dynamic "from" {
    for_each = each.value.from != null ? [each.value.from] : []
    content {
      type  = from.value.type
      value = from.value.value
    }
  }

  dynamic "rule" {
    for_each = each.value.rule != null ? { for k, v in each.value.rule : v.name => v } : {}
    content {
      name                     = rule.value.name
      destination_address      = rule.value.destination_address
      destination_address_name = rule.value.destination_address_name
      application              = rule.value.application
      destination_port         = rule.value.destination_port
      protocol                 = rule.value.protocol
      source_address           = rule.value.source_address
      source_address_name      = rule.value.source_address_name
      dynamic "then" {
        for_each = rule.value.then != null ? [rule.value.then] : []
        content {
          type = then.value.type
          pool = then.value.pool
        }
      }
    }
  }
  description = each.value.description
}
