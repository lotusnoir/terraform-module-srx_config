################################################################################################
### junos_access_address_assignment_pool
################################################################################################

variable "access_address_assignment_pool" {
  type = map(map(object({
    #name             = string
    routing_instance = optional(string)
    family = optional(object({
      type    = optional(string, "inet")
      network = string
      dhcp_attributes = optional(object({
        boot_file                   = optional(string)
        boot_server                 = optional(string)
        dns_server                  = optional(list(string))
        domain_name                 = optional(string)
        exclude_prefix_len          = optional(number)
        grace_period                = optional(number)
        maximum_lease_time          = optional(number)
        maximum_lease_time_infinite = optional(bool)
        name_server                 = optional(list(string))
        netbios_node_type           = optional(string)
        next_server                 = optional(string)
        option                      = optional(set(string))
        option_match_82_circuit_id = optional(object({
          value = optional(string)
          range = optional(string)
        }))
        option_match_82_remote_id = optional(object({
          value = optional(string)
          range = optional(string)
        }))
        preferred_lifetime           = optional(number)
        preferred_lifetime_infinite  = optional(bool)
        propagate_ppp_settings       = optional(set(string))
        propagate_settings           = optional(string)
        router                       = optional(list(string))
        server_identifier            = optional(string)
        sip_server_inet_address      = optional(list(string))
        sip_server_inet_domain_name  = optional(list(string))
        sip_server_inet6_address     = optional(list(string))
        sip_server_inet6_domain_name = optional(string)
        t1_percentage                = optional(number)
        t1_renewal_time              = optional(number)
        t2_percentage                = optional(number)
        t2_rebinding_time            = optional(number)
        tftp_server                  = optional(string)
        valid_lifetime               = optional(number)
        valid_lifetime_infinite      = optional(bool)
        wins_server                  = optional(list(string))
      }))
      excluded_address = optional(set(string))
      excluded_range = optional(object({
        name = optional(string)
        low  = optional(string)
        high = optional(string)
      }))
      host = optional(object({
        name             = optional(string)
        hardware_address = optional(string)
        reserved_address = optional(string)
      }))
      inet_range = optional(object({
        name = optional(string)
        low  = optional(string)
        high = optional(string)
      }))
      inet6_range = optional(object({
        name          = optional(string)
        low           = optional(string)
        high          = optional(string)
        prefix_length = optional(number)
      }))
      xauth_attributes_primary_dns    = optional(string)
      xauth_attributes_primary_wins   = optional(string)
      xauth_attributes_secondary_dns  = optional(string)
      xauth_attributes_secondary_wins = optional(string)
    }))
    active_drain = optional(bool)
    hold_down    = optional(bool)
    link         = optional(string)
  })))
  default = {}
}





resource "junos_access_address_assignment_pool" "this" {
  #for_each = var.access_address_assignment != null ? var.access_address_assignment : null
  for_each = local.flattened_access_address_assignment_pool

  name             = each.value.name
  routing_instance = each.value.routing_instance
  dynamic "family" {
    for_each = each.value.content.family != null ? [each.value.content.family] : []
    content {
      type    = family.value.type
      network = family.value.network
      dynamic "dhcp_attributes" {
        for_each = family.value.dhcp_attributes != null ? [family.value.dhcp_attributes] : []
        content {
          boot_file                   = dhcp_attributes.value.boot_file
          boot_server                 = dhcp_attributes.value.boot_server
          dns_server                  = dhcp_attributes.value.dns_server
          domain_name                 = dhcp_attributes.value.domain_name
          exclude_prefix_len          = dhcp_attributes.value.exclude_prefix_len
          grace_period                = dhcp_attributes.value.grace_period
          maximum_lease_time          = dhcp_attributes.value.maximum_lease_time
          maximum_lease_time_infinite = dhcp_attributes.value.maximum_lease_time_infinite
          name_server                 = dhcp_attributes.value.name_server
          netbios_node_type           = dhcp_attributes.value.netbios_node_type
          next_server                 = dhcp_attributes.value.next_server
          option                      = dhcp_attributes.value.option
          dynamic "option_match_82_circuit_id" {
            for_each = dhcp_attributes.value.option_match_82_circuit_id != null ? [dhcp_attributes.value.option_match_82_circuit_id] : []
            content {
              value = option_match_82_circuit_id.value.value
              range = option_match_82_circuit_id.value.range
            }
          }
          dynamic "option_match_82_remote_id" {
            for_each = dhcp_attributes.value.option_match_82_remote_id != null ? [dhcp_attributes.value.option_match_82_remote_id] : []
            content {
              value = option_match_82_remote_id.value.value
              range = option_match_82_remote_id.value.range
            }
          }
          preferred_lifetime           = dhcp_attributes.value.preferred_lifetime
          preferred_lifetime_infinite  = dhcp_attributes.value.preferred_lifetime_infinite
          propagate_ppp_settings       = dhcp_attributes.value.propagate_ppp_settings
          propagate_settings           = dhcp_attributes.value.propagate_settings
          router                       = dhcp_attributes.value.router
          server_identifier            = dhcp_attributes.value.server_identifier
          sip_server_inet_address      = dhcp_attributes.value.sip_server_inet_address
          sip_server_inet_domain_name  = dhcp_attributes.value.sip_server_inet_domain_name
          sip_server_inet6_address     = dhcp_attributes.value.sip_server_inet6_address
          sip_server_inet6_domain_name = dhcp_attributes.value.sip_server_inet6_domain_name
          t1_percentage                = dhcp_attributes.value.t1_percentage
          t1_renewal_time              = dhcp_attributes.value.t1_renewal_time
          t2_percentage                = dhcp_attributes.value.t2_percentage
          t2_rebinding_time            = dhcp_attributes.value.t2_rebinding_time
          tftp_server                  = dhcp_attributes.value.tftp_server
          valid_lifetime               = dhcp_attributes.value.valid_lifetime
          valid_lifetime_infinite      = dhcp_attributes.value.valid_lifetime_infinite
          wins_server                  = dhcp_attributes.value.wins_server
        }
      }
      excluded_address = family.value.excluded_address
      dynamic "excluded_range" {
        for_each = family.value.excluded_range != null ? [family.value.excluded_range] : []
        content {
          name = excluded_range.value.name
          low  = excluded_range.value.low
          high = excluded_range.value.high
        }
      }
      dynamic "host" {
        for_each = family.value.host != null ? [family.value.host] : []
        content {
          name             = host.value.name
          hardware_address = host.value.hardware_address
          ip_address       = host.value.reserved_address
        }
      }
      dynamic "inet_range" {
        for_each = family.value.inet_range != null ? [family.value.inet_range] : []
        content {
          name = inet_range.value.name
          low  = inet_range.value.low
          high = inet_range.value.high
        }
      }
      dynamic "inet6_range" {
        for_each = family.value.inet6_range != null ? [family.value.inet6_range] : []
        content {
          name          = inet6_range.value.name
          low           = inet6_range.value.low
          high          = inet6_range.value.high
          prefix_length = inet6_range.value.prefix_length
        }
      }
      xauth_attributes_primary_dns    = family.value.xauth_attributes_primary_dns
      xauth_attributes_primary_wins   = family.value.xauth_attributes_primary_wins
      xauth_attributes_secondary_dns  = family.value.xauth_attributes_secondary_dns
      xauth_attributes_secondary_wins = family.value.xauth_attributes_secondary_wins
    }
  }
  active_drain = each.value.content.active_drain
  hold_down    = each.value.content.hold_down
  link         = each.value.content.link
}
