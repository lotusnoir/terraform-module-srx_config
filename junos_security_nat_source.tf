################################################################################################
### junos_security_nat_source
################################################################################################
variable "nat_source" {
  type = map(object({
    from = optional(object({
      type  = string
      value = set(string)
    }))

    to = optional(object({
      type  = string
      value = set(string)
    }))

    rule = optional(map(object({
      #name = string
      match = optional(object({
        application              = optional(set(string))
        destination_address      = optional(set(string))
        destination_address_name = optional(set(string))
        destination_port         = optional(set(string))
        protocol                 = optional(set(string))
        source_address           = optional(set(string))
        source_address_name      = optional(set(string))
        source_port              = optional(set(string))
      }))
      then = optional(object({
        type = string
        pool = optional(string)
      }))
    })))

    description = optional(string)
  }))
  default = {}
}

################################################################################################
resource "junos_security_nat_source" "this" {
  for_each = var.nat_source != null ? var.nat_source : {}

  name = each.key

  dynamic "from" {
    for_each = each.value.from != null ? [each.value.from] : []
    content {
      type  = from.value.type
      value = from.value.value
    }
  }

  dynamic "to" {
    for_each = each.value.to != null ? [each.value.to] : []
    content {
      type  = to.value.type
      value = to.value.value
    }
  }

  dynamic "rule" {
    for_each = each.value.rule != null ? each.value.rule : {}
    content {
      name = rule.key
      dynamic "match" {
        for_each = rule.value.match != null ? [rule.value.match] : []
        content {
          application              = match.value.application
          destination_address      = match.value.destination_address
          destination_address_name = match.value.destination_address_name
          destination_port         = match.value.destination_port
          protocol                 = match.value.protocol
          source_address           = match.value.source_address
          source_address_name      = match.value.source_address_name
          source_port              = match.value.source_port
        }
      }
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
