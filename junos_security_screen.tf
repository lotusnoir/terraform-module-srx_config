################################################################################################
variable "security_screen" {
  type = map(object({
    alarm_without_drop = optional(bool)
    description        = optional(string)
    icmp = optional(object({
      flood            = optional(number)
      fragment         = optional(bool)
      icmpv6_malformed = optional(bool)
      large            = optional(bool)
      ping_death       = optional(bool)
      sweep            = optional(number)
    }))
    ip = optional(object({
      bad_option = optional(bool)
      block_frag = optional(bool)
      ipv6_extension_header = optional(object({
        ah_header  = optional(bool)
        esp_header = optional(bool)
        hip_header = optional(bool)
        destination_header = optional(object({
          ilnp_nonce_option                 = optional(bool)
          home_address_option               = optional(bool)
          line_identification_option        = optional(bool)
          tunnel_encapsulation_limit_option = optional(bool)
          user_defined_option_type          = optional(list(string))
        }))
        fragment_header = optional(bool)
        hop_by_hop_header = optional(object({
          calipso_option           = optional(bool)
          rpl_option               = optional(bool)
          smf_dpd_option           = optional(bool)
          jumbo_payload_option     = optional(bool)
          quick_start_option       = optional(bool)
          router_alert_option      = optional(bool)
          user_defined_option_type = optional(list(string))
        }))
        mobility_header          = optional(bool)
        no_next_header           = optional(bool)
        routing_header           = optional(bool)
        shim6_header             = optional(bool)
        user_defined_header_type = optional(list(string))
      }))
      ipv6_extension_header_limit = optional(number)
      ipv6_malformed_header       = optional(bool)
      loose_source_route_option   = optional(bool)
      record_route_option         = optional(bool)
      security_option             = optional(bool)
      source_route_option         = optional(bool)
      spoofing                    = optional(bool)
      stream_option               = optional(bool)
      strict_source_route_option  = optional(bool)
      tear_drop                   = optional(bool)
      timestamp_option            = optional(bool)
      tunnel = optional(object({
        bad_inner_header = optional(bool)
        gre = optional(object({
          gre_4in4 = optional(bool)
          gre_4in6 = optional(bool)
          gre_6in4 = optional(bool)
          gre_6in6 = optional(bool)
        }))
        ip_in_udp_teredo = optional(bool)
        ipip = optional(object({
          ipip_4in4      = optional(bool)
          ipip_4in6      = optional(bool)
          ipip_6in4      = optional(bool)
          ipip_6in6      = optional(bool)
          ipip_6over4    = optional(bool)
          ipip_6to4relay = optional(bool)
          dslite         = optional(bool)
          isatap         = optional(bool)
        }))
      }))
      unknown_protocol = optional(bool)
    }))
    limit_session = optional(object({
      destination_ip_based = optional(number)
      source_ip_based      = optional(number)
    }))
    tcp = optional(object({
      fin_no_ack        = optional(bool)
      land              = optional(bool)
      no_flag           = optional(bool)
      port_scan         = optional(number)
      syn_ack_ack_proxy = optional(number)
      syn_fin           = optional(bool)
      syn_flood = optional(object({
        alarm_threshold       = optional(number)
        attack_threshold      = optional(number)
        destination_threshold = optional(number)
        source_threshold      = optional(number)
        timeout               = optional(number)
        whitelist = optional(object({
          name                = optional(string)
          destination_address = optional(set(string))
          source_address      = optional(set(string))
        }))
      }))
      syn_frag = optional(bool)
      sweep    = optional(number)
      winnuke  = optional(bool)
    }))
    udp = optional(object({
      flood = optional(object({
        threshold = optional(number)
        whitelist = optional(set(string))
      }))
      port_scan = optional(number)
      sweep     = optional(number)
    }))
  }))
  default = {}
}


################################################################################################
## NOT FINISHED
resource "junos_security_screen" "this" {
  for_each = var.security_screen != null ? var.security_screen : null

  name               = each.key
  alarm_without_drop = each.value.alarm_without_drop
  description        = each.value.description

  dynamic "icmp" {
    for_each = each.value.icmp != null ? [each.value.icmp] : []
    content {
      dynamic "flood" {
        for_each = icmp.value.flood != null ? [icmp.value.flood] : []
        content {
          threshold = icmp.value.flood
        }
      }
      fragment         = icmp.value.fragment
      icmpv6_malformed = icmp.value.icmpv6_malformed
      large            = icmp.value.large
      ping_death       = icmp.value.ping_death
      #dynamic "sweep" {
      #  for_each = icmp.value.sweep != null ? [icmp.value.sweep] : []
      #  content {
      #    threshold = icmp.value.sweep
      #  }
      #}
    }
  }

  dynamic "ip" {
    for_each = each.value.ip != null ? [each.value.ip] : []
    content {
      bad_option = ip.value.bad_option
      block_frag = ip.value.block_frag

      ipv6_extension_header_limit = ip.value.ipv6_extension_header_limit
      ipv6_malformed_header       = ip.value.ipv6_malformed_header
      loose_source_route_option   = ip.value.loose_source_route_option
      record_route_option         = ip.value.record_route_option
      security_option             = ip.value.security_option
      source_route_option         = ip.value.source_route_option
      spoofing                    = ip.value.spoofing
      stream_option               = ip.value.stream_option
      strict_source_route_option  = ip.value.strict_source_route_option
      tear_drop                   = ip.value.tear_drop
      timestamp_option            = ip.value.timestamp_option
      dynamic "tunnel" {
        for_each = ip.value.tunnel != null ? [ip.value.tunnel] : []
        content {
          bad_inner_header = tunnel.value.bad_inner_header

          dynamic "gre" {
            for_each = tunnel.value.gre != null ? [tunnel.value.gre] : []
            content {
              gre_4in4 = gre.value.gre_4in4
              gre_4in6 = gre.value.gre_4in6
              gre_6in4 = gre.value.gre_6in4
              gre_6in6 = gre.value.gre_6in6
            }
          }
          ip_in_udp_teredo = tunnel.value.ip_in_udp_teredo
          dynamic "ipip" {
            for_each = tunnel.value.ipip != null ? [tunnel.value.ipip] : []
            content {
              ipip_4in4      = ipip.value.ipip_4in4
              ipip_4in6      = ipip.value.ipip_4in6
              ipip_6in4      = ipip.value.ipip_6in4
              ipip_6in6      = ipip.value.ipip_6in6
              ipip_6over4    = ipip.value.ipip_6over4
              ipip_6to4relay = ipip.value.ipip_6to4relay
              dslite         = ipip.value.dslite
              isatap         = ipip.value.isatap
            }
          }
        }
      }
      unknown_protocol = ip.value.unknown_protocol
    }
  }
  dynamic "limit_session" {
    for_each = each.value.limit_session != null ? [each.value.limit_session] : []
    content {
      destination_ip_based = limit_session.value.destination_ip_based
      source_ip_based      = limit_session.value.source_ip_based
    }
  }
  dynamic "tcp" {
    for_each = each.value.tcp != null ? [each.value.tcp] : []
    content {

      fin_no_ack = tcp.value.fin_no_ack
      land       = tcp.value.land
      no_flag    = tcp.value.no_flag
      dynamic "port_scan" {
        for_each = tcp.value.port_scan != null ? [tcp.value.port_scan] : []
        content {
          threshold = tcp.value.port_scan
        }
      }
      dynamic "syn_ack_ack_proxy" {
        for_each = tcp.value.syn_ack_ack_proxy != null ? [tcp.value.syn_ack_ack_proxy] : []
        content {
          threshold = tcp.value.syn_ack_ack_proxy
        }
      }
      syn_fin = tcp.value.syn_fin
      dynamic "syn_flood" {
        for_each = tcp.value.syn_flood != null ? [tcp.value.syn_flood] : []
        content {
          alarm_threshold       = syn_flood.value.alarm_threshold
          attack_threshold      = syn_flood.value.attack_threshold
          destination_threshold = syn_flood.value.destination_threshold
          source_threshold      = syn_flood.value.source_threshold
          timeout               = syn_flood.value.timeout
          dynamic "whitelist" {
            for_each = syn_flood.value.whitelist != null ? [syn_flood.value.whitelist] : []
            content {
              name                = whitelist.value.name
              destination_address = whitelist.value.destination_address
              source_address      = whitelist.value.source_address
            }
          }
        }
      }
      syn_frag = tcp.value.syn_frag
      dynamic "sweep" {
        for_each = tcp.value.sweep != null ? [tcp.value.sweep] : []
        content {
          threshold = tcp.value.sweep
        }
      }
      winnuke = tcp.value.winnuke
    }
  }
}
