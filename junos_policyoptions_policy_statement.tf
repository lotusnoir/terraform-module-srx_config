##################################################################################
variable "policy_statements" {
  type = map(object({
    add_it_to_forwarding_table_export = optional(bool)
    dynamic_db                        = optional(bool)

    ##OK
    from = optional(object({
      aggregate_contributor = optional(bool)
      bgp_as_path           = optional(set(string))
      bgp_as_path_calc_length = optional(map(object({
        count = optional(number)
        match = optional(string)
      })))
      bgp_as_path_group = optional(set(string))
      bgp_as_path_unique_count = optional(object({
        count = optional(number)
        match = optional(string)
      }))
      bgp_community = optional(set(string))
      bgp_community_count = optional(object({
        count = optional(number)
        match = optional(string)
      }))
      bgp_origin             = optional(string)
      bgp_srte_discriminator = optional(number)
      color                  = optional(number)
      evpn_esi               = optional(set(string))
      evpn_mac_route         = optional(string)
      evpn_tag               = optional(set(string))
      family                 = optional(string)
      local_preference       = optional(number)
      interface              = optional(set(string))
      metric                 = optional(number)
      neighbor               = optional(set(string))
      next_hop               = optional(set(string))
      next_hop_type_merged   = optional(bool)
      next_hop_weight = optional(object({
        match  = optional(string)
        weight = optional(number)
      }))
      ospf_area           = optional(string)
      policy              = optional(list(string))
      preference          = optional(number)
      prefix_list         = optional(set(string))
      protocol            = optional(set(string))
      route_filter        = optional(set(string))
      route_filter_option = optional(string, "exact")
      route_filter_value  = optional(string, "accept")
      route_type          = optional(string)
      routing_instance    = optional(string)
      srte_color          = optional(number)
      state               = optional(string)
      tunnel_type         = optional(set(string))
      validation_database = optional(string)
    }))

    ##OK
    to = optional(object({
      bgp_as_path       = optional(set(string))
      bgp_as_path_group = optional(set(string))
      bgp_community     = optional(set(string))
      bgp_origin        = optional(string)
      family            = optional(string)
      local_preference  = optional(number)
      interface         = optional(set(string))
      metric            = optional(number)
      neighbor          = optional(set(string))
      next_hop          = optional(set(string))
      ospf_area         = optional(string)
      policy            = optional(list(string))
      preference        = optional(number)
      protocol          = optional(set(string))
      routing_instance  = optional(string)
    }))

    ##OK
    then = optional(object({
      action          = optional(string)
      as_path_expand  = optional(string)
      as_path_prepend = optional(string)
      community = optional(object({
        action = optional(string)
        value  = optional(string)
      }))
      default_action = optional(string)
      load_balance   = optional(string)
      local_preference = optional(object({
        action = optional(string)
        value  = optional(string)
      }))
      metric = optional(object({
        action = optional(string)
        value  = optional(string)
      }))
      next     = optional(string)
      next_hop = optional(string)
      origin   = optional(string)
      preference = optional(object({
        action = optional(string)
        value  = optional(string)
      }))
    }))

    term = optional(map(object({
      ##OK
      from = optional(object({
        aggregate_contributor = optional(bool)
        bgp_as_path           = optional(set(string))
        bgp_as_path_calc_length = optional(map(object({
          count = optional(number)
          match = optional(string)
        })))
        bgp_as_path_group = optional(set(string))
        bgp_as_path_unique_count = optional(object({
          count = optional(number)
          match = optional(string)
        }))
        bgp_community = optional(set(string))
        bgp_community_count = optional(object({
          count = optional(number)
          match = optional(string)
        }))
        bgp_origin             = optional(string)
        bgp_srte_discriminator = optional(number)
        color                  = optional(number)
        evpn_esi               = optional(set(string))
        evpn_mac_route         = optional(string)
        evpn_tag               = optional(set(string))
        family                 = optional(string)
        local_preference       = optional(number)
        interface              = optional(set(string))
        metric                 = optional(number)
        neighbor               = optional(set(string))
        next_hop               = optional(set(string))
        next_hop_type_merged   = optional(bool)
        next_hop_weight = optional(object({
          match  = optional(string)
          weight = optional(number)
        }))
        ospf_area           = optional(string)
        policy              = optional(list(string))
        preference          = optional(number)
        prefix_list         = optional(set(string))
        protocol            = optional(set(string))
        route_filter        = optional(set(string))
        route_filter_option = optional(string, "exact")
        route_filter_value  = optional(string, "accept")
        route_type          = optional(string)
        routing_instance    = optional(string)
        srte_color          = optional(number)
        state               = optional(string)
        tunnel_type         = optional(set(string))
        validation_database = optional(string)
      }))

      ##OK
      then = optional(object({
        action          = optional(string)
        as_path_expand  = optional(string)
        as_path_prepend = optional(string)
        community = optional(object({
          action = optional(string)
          value  = optional(string)
        }))
        default_action = optional(string)
        load_balance   = optional(string)
        local_preference = optional(object({
          action = optional(string)
          value  = optional(string)
        }))
        metric = optional(object({
          action = optional(string)
          value  = optional(string)
        }))
        next     = optional(string)
        next_hop = optional(string)
        origin   = optional(string)
        preference = optional(object({
          action = optional(string)
          value  = optional(string)
        }))
      }))
    })))
  }))
  default = {}
}


#########################################################################
## Routing policy, we add here the routes that we accept inside the firewall and the ones we send to the network
#########################################################################
resource "junos_policyoptions_policy_statement" "this" {
  for_each = var.policy_statements != null ? var.policy_statements : null

  name                              = each.key
  add_it_to_forwarding_table_export = each.value.add_it_to_forwarding_table_export
  dynamic_db                        = each.value.dynamic_db

  dynamic "from" {
    for_each = each.value.from != null ? [each.value.from] : []
    iterator = from

    content {
      aggregate_contributor = from.value.aggregate_contributor
      bgp_as_path           = from.value.bgp_as_path
      dynamic "bgp_as_path_calc_length" {
        for_each = from.value.bgp_as_path_calc_length != null ? [from.value.bgp_as_path_calc_length] : []
        content {
          count = bgp_as_path_calc_length.value.count
          match = bgp_as_path_calc_length.value.match
        }
      }
      bgp_as_path_group = from.value.bgp_as_path_group
      dynamic "bgp_as_path_unique_count" {
        for_each = from.value.bgp_as_path_unique_count != null ? [from.value.bgp_as_path_unique_count] : []
        content {
          count = bgp_as_path_unique_count.value.count
          match = bgp_as_path_unique_count.value.match
        }
      }
      bgp_community = from.value.bgp_community
      dynamic "bgp_community_count" {
        for_each = from.value.bgp_community_count != null ? [from.value.bgp_community_count] : []
        content {
          count = bgp_community_count.value.count
          match = bgp_community_count.value.match
        }
      }
      bgp_origin             = from.value.bgp_origin
      bgp_srte_discriminator = from.value.bgp_srte_discriminator
      color                  = from.value.color
      evpn_esi               = from.value.evpn_esi
      evpn_mac_route         = from.value.evpn_mac_route
      evpn_tag               = from.value.evpn_tag
      family                 = from.value.family
      local_preference       = from.value.local_preference
      interface              = from.value.interface
      metric                 = from.value.metric
      neighbor               = from.value.neighbor
      next_hop               = from.value.next_hop
      next_hop_type_merged   = from.value.next_hop_type_merged
      dynamic "next_hop_weight" {
        for_each = from.value.next_hop_weight != null ? [from.value.next_hop_weight] : []
        content {
          match  = next_hop_weight.value.match
          weight = next_hop_weight.value.weight
        }
      }
      ospf_area   = from.value.ospf_area
      policy      = from.value.policy
      preference  = from.value.preference
      prefix_list = from.value.prefix_list
      protocol    = from.value.protocol
      dynamic "route_filter" {
        for_each = from.value.route_filter != null ? from.value.route_filter : []
        content {
          route        = route_filter.value
          option       = from.value.route_filter_option
          option_value = from.value.route_filter_value
        }
      }
    }
  }

  dynamic "to" {
    for_each = each.value.to != null ? [each.value.to] : []
    iterator = to
    content {
      bgp_as_path       = to.value.bgp_as_path
      bgp_as_path_group = to.value.bgp_as_path_group
      bgp_community     = to.value.bgp_community
      bgp_origin        = to.value.bgp_origin
      family            = to.value.family
      local_preference  = to.value.interface
      interface         = to.value.interface
      metric            = to.value.metric
      neighbor          = to.value.neighbor
      next_hop          = to.value.next_hop
      ospf_area         = to.value.ospf_area
      policy            = to.value.policy
      preference        = to.value.preference
      protocol          = to.value.protocol
      routing_instance  = to.value.routing_instance
    }
  }

  dynamic "then" {
    for_each = each.value.then != null ? [each.value.then] : []
    iterator = then
    content {
      action          = then.value.action
      as_path_expand  = then.value.as_path_expand
      as_path_prepend = then.value.as_path_prepend

      dynamic "community" {
        for_each = then.value.community != null ? [then.value.community] : []
        content {
          action = community.value.action
          value  = community.value.value
        }
      }
      default_action = then.value.default_action
      load_balance   = then.value.load_balance
      dynamic "local_preference" {
        for_each = then.value.local_preference != null ? [then.value.local_preference] : []
        content {
          action = local_preference.value.action
          value  = local_preference.value.value
        }
      }
      dynamic "metric" {
        for_each = then.value.metric != null ? [then.value.metric] : []
        content {
          action = metric.value.action
          value  = metric.value.value
        }
      }
      next     = then.value.next
      next_hop = then.value.next_hop
      origin   = then.value.origin
      dynamic "preference" {
        for_each = then.value.preference != null ? [then.value.preference] : []
        content {
          action = preference.value.action
          value  = preference.value.value
        }
      }
    }
  }

  dynamic "term" {
    for_each = each.value.term != null ? each.value.term : {}
    iterator = term
    content {
      name = term.key

      dynamic "from" {
        for_each = term.value.from != null ? [term.value.from] : []
        iterator = from
        content {
          aggregate_contributor = from.value.aggregate_contributor
          bgp_as_path           = from.value.bgp_as_path
          dynamic "bgp_as_path_calc_length" {
            for_each = from.value.bgp_as_path_calc_length != null ? [from.value.bgp_as_path_calc_length] : []
            content {
              count = bgp_as_path_calc_length.value.count
              match = bgp_as_path_calc_length.value.match
            }
          }
          bgp_as_path_group = from.value.bgp_as_path_group
          dynamic "bgp_as_path_unique_count" {
            for_each = from.value.bgp_as_path_unique_count != null ? [from.value.bgp_as_path_unique_count] : []
            content {
              count = bgp_as_path_unique_count.value.count
              match = bgp_as_path_unique_count.value.match
            }
          }
          bgp_community = from.value.bgp_community
          dynamic "bgp_community_count" {
            for_each = from.value.bgp_community_count != null ? [from.value.bgp_community_count] : []
            content {
              count = bgp_community_count.value.count
              match = bgp_community_count.value.match
            }
          }
          bgp_origin             = from.value.bgp_origin
          bgp_srte_discriminator = from.value.bgp_srte_discriminator
          color                  = from.value.color
          evpn_esi               = from.value.evpn_esi
          evpn_mac_route         = from.value.evpn_mac_route
          evpn_tag               = from.value.evpn_tag
          family                 = from.value.family
          local_preference       = from.value.local_preference
          interface              = from.value.interface
          metric                 = from.value.metric
          neighbor               = from.value.neighbor
          next_hop               = from.value.next_hop
          next_hop_type_merged   = from.value.next_hop_type_merged
          dynamic "next_hop_weight" {
            for_each = from.value.next_hop_weight != null ? [from.value.next_hop_weight] : []
            content {
              match  = next_hop_weight.value.match
              weight = next_hop_weight.value.weight
            }
          }
          ospf_area   = from.value.ospf_area
          policy      = from.value.policy
          preference  = from.value.preference
          prefix_list = from.value.prefix_list
          protocol    = from.value.protocol
          dynamic "route_filter" {
            for_each = from.value.route_filter != null ? from.value.route_filter : []
            content {
              route        = route_filter.value
              option       = from.value.route_filter_option
              option_value = from.value.route_filter_value
            }
          }
          route_type          = from.value.route_type
          routing_instance    = from.value.routing_instance
          srte_color          = from.value.srte_color
          state               = from.value.state
          tunnel_type         = from.value.tunnel_type
          validation_database = from.value.validation_database
        }
      }

      dynamic "then" {
        for_each = term.value.then != null ? [term.value.then] : []
        iterator = then
        content {
          action          = then.value.action
          as_path_expand  = then.value.as_path_expand
          as_path_prepend = then.value.as_path_prepend

          dynamic "community" {
            for_each = then.value.community != null ? [then.value.community] : []
            content {
              action = community.value.action
              value  = community.value.value
            }
          }
          default_action = then.value.default_action
          load_balance   = then.value.load_balance
          dynamic "local_preference" {
            for_each = then.value.local_preference != null ? [then.value.local_preference] : []
            content {
              action = local_preference.value.action
              value  = local_preference.value.value
            }
          }
          dynamic "metric" {
            for_each = then.value.metric != null ? [then.value.metric] : []
            content {
              action = metric.value.action
              value  = metric.value.value
            }
          }
          next     = then.value.next
          next_hop = then.value.next_hop
          origin   = then.value.origin
          dynamic "preference" {
            for_each = then.value.preference != null ? [then.value.preference] : []
            content {
              action = preference.value.action
              value  = preference.value.value
            }
          }
        }
      }
    }
  }
}
