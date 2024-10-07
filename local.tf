locals {
  flattened_bgp_group = merge([
    for routing_key, routing_val in var.bgp_group : {
      for group_key, group_val in routing_val :
      "${group_key}_-_${routing_key}" => {
        routing_instance = routing_key
        name             = group_key
        content          = group_val
      }
    }
  ]...)

  flattened_static_route = merge([
    for routing_key, routing_val in var.static_route : {
      for group_key, group_val in routing_val :
      "${group_key}_-_${routing_key}" => {
        routing_instance = routing_key
        destination      = group_key
        content          = group_val
      }
    }
  ]...)


  flattened_access_address_assignment_pool = merge([
    for routing_key, routing_val in var.access_address_assignment_pool : {
      for group_key, group_val in routing_val :
      "${group_key}_-_${routing_key}" => {
        routing_instance = routing_key
        name             = group_key
        content          = group_val
      }
    }
  ]...)
}
