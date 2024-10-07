################################################################################################
variable "static_route" {
  type = map(map(object({
    routing_instance             = optional(string)
    active                       = optional(bool)
    as_path_aggregator_address   = optional(string)
    as_path_aggregator_as_number = optional(string)
    as_path_atomic_aggregate     = optional(bool)
    as_path_origin               = optional(string)
    as_path_path                 = optional(string)
    community                    = optional(list(string))
    discard                      = optional(bool)
    install                      = optional(bool)
    no_install                   = optional(bool)
    metric                       = optional(number)
    next_hop                     = optional(list(string))
    next_table                   = optional(string)
    passive                      = optional(bool)
    preference                   = optional(number)

    qualified_next_hop = optional(object({
      next_hop   = optional(string)
      interface  = optional(string)
      metric     = optional(number)
      preference = optional(number)
    }))

    readvertise    = optional(bool)
    no_readvertise = optional(bool)
    receive        = optional(bool)
    reject         = optional(bool)
    resolve        = optional(bool)
    no_resolve     = optional(bool)
    retain         = optional(bool)
    no_retain      = optional(bool)
  })))
  default = {}
}


################################################################################################
resource "junos_static_route" "this" {
  #for_each = var.static_route != null ? var.static_route : null
  for_each = local.flattened_static_route

  destination                  = each.value.destination
  routing_instance             = each.value.routing_instance
  active                       = each.value.content.active
  as_path_aggregator_address   = each.value.content.as_path_aggregator_address
  as_path_aggregator_as_number = each.value.content.as_path_aggregator_as_number
  as_path_atomic_aggregate     = each.value.content.as_path_atomic_aggregate
  as_path_origin               = each.value.content.as_path_origin
  as_path_path                 = each.value.content.as_path_path
  community                    = each.value.content.community
  discard                      = each.value.content.discard
  install                      = each.value.content.install
  no_install                   = each.value.content.no_install
  metric                       = each.value.content.metric
  next_hop                     = each.value.content.next_hop
  next_table                   = each.value.content.next_table
  passive                      = each.value.content.passive
  preference                   = each.value.content.preference

  dynamic "qualified_next_hop" {
    for_each = each.value.content.qualified_next_hop != null ? [each.value.content.qualified_next_hop] : []
    content {
      next_hop   = qualified_next_hop.value.next_hop
      interface  = qualified_next_hop.value.interface
      metric     = qualified_next_hop.value.metric
      preference = qualified_next_hop.value.preference
    }
  }

  readvertise    = each.value.content.readvertise
  no_readvertise = each.value.content.no_readvertise
  receive        = each.value.content.receive
  reject         = each.value.content.reject
  resolve        = each.value.content.resolve
  no_resolve     = each.value.content.no_resolve
  retain         = each.value.content.retain
  no_retain      = each.value.content.no_retain
}
