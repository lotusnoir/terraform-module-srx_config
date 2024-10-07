##################################################################################
variable "interfaces_logical" {
  type = map(object({
    st0_also_on_destroy = optional(bool)
    description         = optional(string)
    disable             = optional(bool)
    family_inet = optional(object({
      address = optional(list(object({
        cidr_ip   = optional(string)
        preferred = optional(bool)
        primary   = optional(bool)
        #vrrp_group = optional(list(string))
      })))
      dhcp = optional(list(object({
        srx_old_option_name                            = optional(bool)
        client_identifier_ascii                        = optional(string)
        client_identifier_hexadecimal                  = optional(string)
        client_identifier_prefix_hostname              = optional(bool)
        client_identifier_prefix_routing_instance_name = optional(bool)
        client_identifier_use_interface_description    = optional(bool)
        client_identifier_userid_ascii                 = optional(string)
        client_identifier_userid_hexadecimal           = optional(string)
        force_discover                                 = optional(bool)
        lease_time                                     = optional(number)
        lease_time_infinite                            = optional(bool)
        metric                                         = optional(number)
        no_dns_install                                 = optional(bool)
        options_no_hostname                            = optional(bool)
        retransmission_attempt                         = optional(number)
        retransmission_interval                        = optional(number)
        server_address                                 = optional(string)
        update_server                                  = optional(bool)
        vendor_id                                      = optional(string)
      })))
      filter_input  = optional(string)
      filter_output = optional(string)
      mtu           = optional(number)
      rpf_check = optional(list(object({
        fail_filter = optional(string)
        mode_loose  = optional(bool)
      })))
      sampling_input  = optional(bool)
      sampling_output = optional(bool)
    }))

    family_inet6 = optional(object({
      address = optional(list(object({
        cidr_ip   = optional(string)
        preferred = optional(bool)
        primary   = optional(bool)
        #vrrp_group = optional(list(string))
      })))
      dad_disable = optional(bool)
      dhcpv6_client = optional(list(object({
        client_identifier_duid_type               = optional(string)
        client_type                               = optional(string)
        client_ia_type_na                         = optional(bool)
        client_ia_type_pd                         = optional(bool)
        no_dns_install                            = optional(bool)
        prefix_delegating_preferred_prefix_length = optional(number)
        prefix_delegating_sub_prefix_length       = optional(number)
        rapid_commit                              = optional(bool)
        req_option                                = optional(set(string))
        retransmission_attempt                    = optional(number)
        update_router_advertisement_interface     = optional(set(string))
        update_server                             = optional(bool)
      })))
      filter_input  = optional(string)
      filter_output = optional(string)
      mtu           = optional(number)
      rpf_check = optional(list(object({
        fail_filter = optional(string)
        mode_loose  = optional(bool)
      })))
      sampling_input  = optional(bool)
      sampling_output = optional(bool)
    }))
    routing_instance           = optional(string)
    security_inbound_protocols = optional(set(string))
    security_inbound_services  = optional(set(string))
    security_zone              = optional(string)
    tunnel = optional(list(object({
      destination                  = optional(string)
      source                       = optional(string)
      allow_fragmentation          = optional(bool)
      do_not_fragment              = optional(bool)
      flow_label                   = optional(number)
      path_mtu_discovery           = optional(bool)
      no_path_mtu_discovery        = optional(bool)
      routing_instance_destination = optional(string)
      traffic_class                = optional(number)
      ttl                          = optional(number)
    })))
    vlan_id         = optional(string)
    vlan_no_compute = optional(bool)
  }))
  default = {}
}


##################################################################################
### All options with v2.6.0 NOK block to do in address
resource "junos_interface_logical" "this" {
  for_each   = var.interfaces_logical
  depends_on = [junos_security_zone.this]

  name                = each.key
  st0_also_on_destroy = each.value.st0_also_on_destroy
  description         = each.value.description != null ? each.value.description : each.value.security_zone
  disable             = each.value.disable

  dynamic "family_inet" {
    for_each = each.value.family_inet != null ? [each.value.family_inet] : []
    content {
      dynamic "address" {
        for_each = family_inet.value.address != null ? family_inet.value.address : []
        content {
          cidr_ip   = address.value.cidr_ip
          preferred = address.value.preferred
          primary   = address.value.primary
          #vrrp_group   = address.value.vrrp_group
        }
      }

      dynamic "dhcp" {
        for_each = family_inet.value.dhcp != null ? [1] : []
        content {
          srx_old_option_name                            = dhcp.value.srx_old_option_name
          client_identifier_ascii                        = dhcp.value.client_identifier_ascii
          client_identifier_hexadecimal                  = dhcp.value.client_identifier_hexadecimal
          client_identifier_prefix_hostname              = dhcp.value.client_identifier_prefix_hostname
          client_identifier_prefix_routing_instance_name = dhcp.value.client_identifier_prefix_routing_instance_name
          client_identifier_use_interface_description    = dhcp.value.client_identifier_use_interface_description
          client_identifier_userid_ascii                 = dhcp.value.client_identifier_userid_ascii
          client_identifier_userid_hexadecimal           = dhcp.value.client_identifier_userid_hexadecimal
          force_discover                                 = dhcp.value.force_discover
          lease_time                                     = dhcp.value.lease_time
          lease_time_infinite                            = dhcp.value.lease_time_infinite
          metric                                         = dhcp.value.metric
          no_dns_install                                 = dhcp.value.no_dns_install
          options_no_hostname                            = dhcp.value.options_no_hostname
          retransmission_attempt                         = dhcp.value.retransmission_attempt
          retransmission_interval                        = dhcp.value.retransmission_interval
          server_address                                 = dhcp.value.server_address
          update_server                                  = dhcp.value.update_server
          vendor_id                                      = dhcp.value.vendor_id
        }
      }

      filter_input  = family_inet.value.filter_input
      filter_output = family_inet.value.filter_output
      mtu           = family_inet.value.mtu

      dynamic "rpf_check" {
        for_each = family_inet.value.rpf_check != null ? [family_inet.value.rpf_check] : []
        content {
          fail_filter = rpf_check.value.fail_filter
          mode_loose  = rpf_check.value.mode_loose
        }
      }

      sampling_input  = family_inet.value.sampling_input
      sampling_output = family_inet.value.sampling_output
    }
  }

  dynamic "family_inet6" {
    for_each = each.value.family_inet6 != null ? [each.value.family_inet6] : []
    content {
      dynamic "address" {
        for_each = family_inet6.value.address != null ? family_inet6.value.address : []
        content {
          cidr_ip   = address.value.cidr_ip
          preferred = address.value.preferred
          primary   = address.value.primary
          #vrrp_group   = address.value.vrrp_group
        }
      }

      dad_disable = family_inet6.value.dad_disable
      dynamic "dhcpv6_client" {
        for_each = family_inet6.value.dhcpv6_client != null ? [1] : []
        content {
          client_identifier_duid_type               = dhcpv6_client.value.client_identifier_duid_type
          client_type                               = dhcpv6_client.value.client_type
          client_ia_type_na                         = dhcpv6_client.value.client_ia_type_na
          client_ia_type_pd                         = dhcpv6_client.value.client_ia_type_pd
          no_dns_install                            = dhcpv6_client.value.no_dns_install
          prefix_delegating_preferred_prefix_length = dhcpv6_client.value.prefix_delegating_preferred_prefix_length
          prefix_delegating_sub_prefix_length       = dhcpv6_client.value.prefix_delegating_sub_prefix_length
          rapid_commit                              = dhcpv6_client.value.rapid_commit
          req_option                                = dhcpv6_client.value.req_option
          retransmission_attempt                    = dhcpv6_client.value.retransmission_attempt
          update_router_advertisement_interface     = dhcpv6_client.value.update_router_advertisement_interface
          update_server                             = dhcpv6_client.value.update_server
        }
      }

      filter_input  = family_inetv6.value.filter_input
      filter_output = family_inetv6.value.filter_output
      mtu           = family_inetv6.value.mtu

      dynamic "rpf_check" {
        for_each = family_inet6.value.rpf_check != null ? [1] : []
        content {
          fail_filter = rpf_check.value.fail_filter
          mode_loose  = rpf_check.value.mode_loose
        }
      }

      sampling_input  = family_inetv6.value.sampling_input
      sampling_output = family_inetv6.value.sampling_output
    }
  }

  routing_instance           = each.value.routing_instance
  security_inbound_protocols = each.value.security_inbound_protocols
  security_inbound_services  = each.value.security_inbound_services
  security_zone              = each.value.security_zone

  dynamic "tunnel" {
    for_each = each.value.tunnel != null ? [1] : []
    content {
      destination                  = tunnel.value.destination
      source                       = tunnel.value.source
      allow_fragmentation          = tunnel.value.allow_fragmentation
      do_not_fragment              = tunnel.value.do_not_fragment
      flow_label                   = tunnel.value.flow_label
      path_mtu_discovery           = tunnel.value.path_mtu_discovery
      no_path_mtu_discovery        = tunnel.value.no_path_mtu_discovery
      routing_instance_destination = tunnel.value.routing_instance_destination
      traffic_class                = tunnel.value.traffic_class
      ttl                          = tunnel.value.ttl
    }
  }

  vlan_id         = each.value.vlan_id
  vlan_no_compute = each.value.vlan_no_compute
}
