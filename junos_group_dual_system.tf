##################################################################################
variable "system_group_pool" {
  type = map(object({
    apply_groups = optional(bool)
    interface_fxp0 = optional(object({
      description = optional(string)
      family_inet_address = optional(object({
        cidr_ip     = string
        master_only = optional(bool)
        preferred   = optional(bool)
        primary     = optional(bool)
      }))
      family_inet6_address = optional(object({
        cidr_ip     = string
        master_only = optional(bool)
        preferred   = optional(bool)
        primary     = optional(bool)
      }))
    }))
    routing_options = optional(object({
      static_route = list(object({
        destination = string
        next_hop    = optional(list(string))
      }))
    }))
    security = optional(object({
      log_source_address = string
    }))
    system = optional(object({
      host_name                       = optional(string)
      backup_router_address           = optional(string)
      backup_router_destination       = optional(set(string))
      inet6_backup_router_address     = optional(string)
      inet6_backup_router_destination = optional(set(string))
    }))
  }))
  default = null
}

resource "junos_group_dual_system" "this" {
  for_each = var.system_group_pool != null ? var.system_group_pool : {}

  name         = each.key
  apply_groups = each.value.apply_groups

  dynamic "interface_fxp0" {
    for_each = each.value.interface_fxp0 != null ? [each.value.interface_fxp0] : []
    iterator = int
    content {
      description = int.value.description
      dynamic "family_inet_address" {
        for_each = int.value.family_inet_address != null ? [int.value.family_inet_address] : []
        iterator = item
        content {
          cidr_ip     = item.value.cidr_ip
          master_only = item.value.master_only
          preferred   = item.value.preferred
          primary     = item.value.primary
        }
      }
      dynamic "family_inet6_address" {
        for_each = int.value.family_inet6_address != null ? [int.value.family_inet6_address] : []
        iterator = item
        content {
          cidr_ip     = item.value.cidr_ip
          master_only = item.value.master_only
          preferred   = item.value.preferred
          primary     = item.value.primary
        }
      }
    }
  }
  dynamic "routing_options" {
    for_each = each.value.routing_options != null ? [each.value.routing_options] : []
    content {
      dynamic "static_route" {
        for_each = routing_options.value.static_route != null ? [routing_options.value.static_route] : []
        iterator = item
        content {
          destination = item.value.destination
          next_hop    = item.value.next_hop
        }
      }
    }
  }
  dynamic "security" {
    for_each = each.value.security != null ? [each.value.security] : []
    content {
      log_source_address = security.value.log_source_address
    }
  }
  dynamic "system" {
    for_each = each.value.system != null ? [each.value.system] : []
    iterator = item
    content {
      host_name                       = item.value.host_name
      backup_router_address           = item.value.backup_router_address
      backup_router_destination       = item.value.backup_router_destination
      inet6_backup_router_address     = item.value.inet6_backup_router_address
      inet6_backup_router_destination = item.value.inet6_backup_router_destination
    }
  }
}
