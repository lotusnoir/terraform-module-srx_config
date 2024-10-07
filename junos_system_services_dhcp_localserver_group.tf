#################################################################################################
variable "dhcp_servers" {
  type = map(object({
    routing_instance        = optional(string)
    version                 = optional(string, "v4")
    access_profile          = optional(string)
    authentication_password = optional(string)
    authentication_username_include = optional(object({
      circuit_type                               = optional(bool)
      client_id                                  = optional(bool)
      client_id_exclude_headers                  = optional(bool)
      client_id_use_automatic_ascii_hex_encoding = optional(bool)
      delimiter                                  = optional(string)
      domain_name                                = optional(string)
      interface_description                      = optional(string)
      interface_name                             = optional(bool)
      mac_address                                = optional(bool)
      option_60                                  = optional(bool)
      option_82                                  = optional(bool)
      option_82_circuit_id                       = optional(bool)
      option_82_remote_id                        = optional(bool)
      relay_agent_interface_id                   = optional(bool)
      relay_agent_remote_id                      = optional(bool)
      relay_agent_subscriber_id                  = optional(bool)
      routing_instance_name                      = optional(bool)
      user_prefix                                = optional(string)
      vlan_tags                                  = optional(bool)
    }))
    dynamic_profile                          = optional(string)
    dynamic_profile_use_primary              = optional(string)
    dynamic_profile_aggregate_clients        = optional(bool)
    dynamic_profile_aggregate_clients_action = optional(string)
    interface = optional(object({
      name                                     = optional(string)
      access_profile                           = optional(string)
      dynamic_profile                          = optional(string)
      dynamic_profile_use_primary              = optional(string)
      dynamic_profile_aggregate_clients        = optional(bool)
      dynamic_profile_aggregate_clients_action = optional(string)
      exclude                                  = optional(bool)
      overrides_v4 = optional(object({
        allow_no_end_option   = optional(string)
        asymmetric_lease_time = optional(number)
        bootp_support         = optional(bool)
        client_discover_match = optional(string)
        delay_offer_based_on = optional(object({
          option     = optional(string)
          compare    = optional(string)
          value_type = optional(string)
          value      = optional(string)
        }))
        delay_offer_delay_time          = optional(number)
        delete_binding_on_renegotiation = optional(bool)
        dual_stack                      = optional(string)
        include_option_82_forcerenew    = optional(bool)
        include_option_82_nak           = optional(bool)
        interface_client_limit          = optional(number)
        process_inform                  = optional(bool)
        process_inform_pool             = optional(string)
        protocol_attributes             = optional(string)
      }))
      overrides_v6 = optional(object({
        always_add_option_dns_server                = optional(bool)
        always_process_option_request_option        = optional(bool)
        asymmetric_lease_time                       = optional(number)
        asymmetric_prefix_lease_time                = optional(number)
        client_negotiation_match_incoming_interface = optional(bool)
        delay_advertise_based_on = optional(object({
          option     = optional(string)
          compare    = optional(string)
          value_type = optional(string)
          value      = optional(string)
        }))
        delay_advertise_delay_time             = optional(number)
        delegated_pool                         = optional(string)
        delete_binding_on_renegotiation        = optional(bool)
        dual_stack                             = optional(string)
        interface_client_limit                 = optional(number)
        multi_address_embedded_option_response = optional(bool)
        process_inform                         = optional(bool)
        process_inform_pool                    = optional(string)
        protocol_attributes                    = optional(string)
        rapid_commit                           = optional(bool)
        top_level_status_code                  = optional(bool)
      }))
      service_profile                         = optional(string)
      short_cycle_protection_lockout_max_time = optional(number)
      short_cycle_protection_lockout_min_time = optional(number)
      trace                                   = optional(bool)
      upto                                    = optional(string)
    }))
    lease_time_validation = optional(object({
      lease_time_threshold = optional(number)
      violation_action     = optional(string)
    }))
    liveness_detection_failure_action = optional(string)
    liveness_detection_method_bfd = optional(object({
      detection_time_threshold    = optional(number)
      holddown_interval           = optional(number)
      minimum_interval            = optional(number)
      minimum_receive_interval    = optional(number)
      multiplier                  = optional(number)
      no_adaptation               = optional(bool)
      session_mode                = optional(string)
      transmit_interval_minimum   = optional(number)
      transmit_interval_threshold = optional(number)
      version                     = optional(string)
    }))
    liveness_detection_method_layer2 = optional(object({
      max_consecutive_retries = optional(number)
      transmit_interval       = optional(number)
    }))
    overrides_v4 = optional(object({
      allow_no_end_option   = optional(string)
      asymmetric_lease_time = optional(number)
      bootp_support         = optional(bool)
      client_discover_match = optional(string)
      delay_offer_based_on = optional(object({
        option     = optional(string)
        compare    = optional(string)
        value_type = optional(string)
        value      = optional(string)
      }))
      delay_offer_delay_time          = optional(number)
      delete_binding_on_renegotiation = optional(bool)
      dual_stack                      = optional(string)
      include_option_82_forcerenew    = optional(bool)
      include_option_82_nak           = optional(bool)
      interface_client_limit          = optional(number)
      process_inform                  = optional(bool)
      process_inform_pool             = optional(string)
      protocol_attributes             = optional(string)
    }))
    overrides_v6 = optional(object({
      always_add_option_dns_server                = optional(bool)
      always_process_option_request_option        = optional(bool)
      asymmetric_lease_time                       = optional(number)
      asymmetric_prefix_lease_time                = optional(number)
      client_negotiation_match_incoming_interface = optional(bool)
      delay_advertise_based_on = optional(object({
        option     = optional(string)
        compare    = optional(string)
        value_type = optional(string)
        value      = optional(string)
      }))
      delay_advertise_delay_time             = optional(number)
      delegated_pool                         = optional(string)
      delete_binding_on_renegotiation        = optional(bool)
      dual_stack                             = optional(string)
      interface_client_limit                 = optional(number)
      multi_address_embedded_option_response = optional(bool)
      process_inform                         = optional(bool)
      process_inform_pool                    = optional(string)
      protocol_attributes                    = optional(string)
      rapid_commit                           = optional(bool)
      top_level_status_code                  = optional(bool)
    }))
    reauthenticate_lease_renewal      = optional(bool)
    reauthenticate_remote_id_mismatch = optional(bool)
    reconfigure = optional(object({
      attempts                  = optional(number)
      clear_on_abort            = optional(bool)
      support_option_pd_exclude = optional(bool)
      timeout                   = optional(number)
      token                     = optional(string)
      trigger_radius_disconnect = optional(bool)
    }))
    remote_id_mismatch_disconnect           = optional(bool)
    route_suppression_access                = optional(bool)
    route_suppression_access_internal       = optional(bool)
    route_suppression_destination           = optional(bool)
    service_profile                         = optional(string)
    short_cycle_protection_lockout_max_time = optional(number)
    short_cycle_protection_lockout_min_time = optional(number)
  }))
  default = {}
}


#################################################################################################
resource "junos_system_services_dhcp_localserver_group" "this" {
  for_each = var.dhcp_servers != null ? var.dhcp_servers : null

  name                    = each.key
  routing_instance        = each.value.routing_instance
  version                 = each.value.version
  access_profile          = each.value.access_profile
  authentication_password = each.value.authentication_password

  dynamic "authentication_username_include" {
    for_each = each.value.authentication_username_include != null ? [each.value.authentication_username_include] : []
    iterator = auth
    content {
      circuit_type                               = auth.value.circuit_type
      client_id                                  = auth.value.client_id
      client_id_exclude_headers                  = auth.value.client_id_exclude_headers
      client_id_use_automatic_ascii_hex_encoding = auth.value.client_id_use_automatic_ascii_hex_encoding
      delimiter                                  = auth.value.delimiter
      domain_name                                = auth.value.domain_name
      interface_description                      = auth.value.interface_description
      interface_name                             = auth.value.interface_name
      mac_address                                = auth.value.mac_address
      option_60                                  = auth.value.option_60
      option_82                                  = auth.value.option_82
      option_82_circuit_id                       = auth.value.option_82_circuit_id
      option_82_remote_id                        = auth.value.option_82_remote_id
      relay_agent_interface_id                   = auth.value.relay_agent_interface_id
      relay_agent_remote_id                      = auth.value.relay_agent_remote_id
      relay_agent_subscriber_id                  = auth.value.relay_agent_subscriber_id
      routing_instance_name                      = auth.value.routing_instance_name
      user_prefix                                = auth.value.user_prefix
      vlan_tags                                  = auth.value.vlan_tags
    }
  }

  dynamic_profile                          = each.value.dynamic_profile
  dynamic_profile_use_primary              = each.value.dynamic_profile_use_primary
  dynamic_profile_aggregate_clients        = each.value.dynamic_profile_aggregate_clients
  dynamic_profile_aggregate_clients_action = each.value.dynamic_profile_aggregate_clients_action

  dynamic "interface" {
    for_each = each.value.interface != null ? [each.value.interface] : []
    content {
      name                                     = interface.value.name
      access_profile                           = interface.value.access_profile
      dynamic_profile                          = interface.value.dynamic_profile
      dynamic_profile_use_primary              = interface.value.dynamic_profile_use_primary
      dynamic_profile_aggregate_clients        = interface.value.dynamic_profile_aggregate_clients
      dynamic_profile_aggregate_clients_action = interface.value.dynamic_profile_aggregate_clients_action
      exclude                                  = interface.value.exclude
      #overrides_v4 = interface.value.overrides_v4
      #overrides_v6 = interface.value.overrides_v6
      service_profile                         = interface.value.service_profile
      short_cycle_protection_lockout_max_time = interface.value.short_cycle_protection_lockout_max_time
      short_cycle_protection_lockout_min_time = interface.value.short_cycle_protection_lockout_min_time
      trace                                   = interface.value.trace
      upto                                    = interface.value.upto
    }
  }

  dynamic "lease_time_validation" {
    for_each = each.value.lease_time_validation != null ? [each.value.lease_time_validation] : []
    iterator = lease
    content {
      lease_time_threshold = lease.value.lease_time_threshold
      violation_action     = lease.value.violation_action
    }
  }
  liveness_detection_failure_action = each.value.liveness_detection_failure_action

  dynamic "liveness_detection_method_bfd" {
    for_each = each.value.liveness_detection_method_bfd != null ? [each.value.liveness_detection_method_bfd] : []
    iterator = live
    content {
      detection_time_threshold    = live.value.detection_time_threshold
      holddown_interval           = live.value.holddown_interval
      minimum_interval            = live.value.minimum_interval
      minimum_receive_interval    = live.value.minimum_receive_interval
      multiplier                  = live.value.multiplier
      no_adaptation               = live.value.no_adaptation
      session_mode                = live.value.session_mode
      transmit_interval_minimum   = live.value.transmit_interval_minimum
      transmit_interval_threshold = live.value.transmit_interval_threshold
      version                     = live.value.version
    }
  }

  dynamic "liveness_detection_method_layer2" {
    for_each = each.value.liveness_detection_method_layer2 != null ? [each.value.liveness_detection_method_layer2] : []
    iterator = layer2
    content {
      max_consecutive_retries = layer2.value.max_consecutive_retries
      transmit_interval       = layer2.value.transmit_interval
    }
  }

  dynamic "overrides_v4" {
    for_each = each.value.overrides_v4 != null ? [each.value.overrides_v4] : []
    iterator = v4
    content {
      allow_no_end_option             = v4.value.allow_no_end_option
      asymmetric_lease_time           = v4.value.asymmetric_lease_time
      bootp_support                   = v4.value.bootp_support
      client_discover_match           = v4.value.client_discover_match
      delay_offer_delay_time          = v4.value.delay_offer_delay_time
      delete_binding_on_renegotiation = v4.value.delete_binding_on_renegotiation
      dual_stack                      = v4.value.dual_stack
      include_option_82_forcerenew    = v4.value.include_option_82_forcerenew
      include_option_82_nak           = v4.value.include_option_82_nak
      interface_client_limit          = v4.value.interface_client_limit
      process_inform                  = v4.value.process_inform
      process_inform_pool             = v4.value.process_inform_pool
      protocol_attributes             = v4.value.protocol_attributes
    }
  }

  #overrides_v6
  reauthenticate_lease_renewal      = each.value.reauthenticate_lease_renewal
  reauthenticate_remote_id_mismatch = each.value.reauthenticate_remote_id_mismatch

  dynamic "reconfigure" {
    for_each = each.value.reconfigure != null ? [each.value.reconfigure] : []
    iterator = reconfigure
    content {
      attempts                  = reconfigure.value.attempts
      clear_on_abort            = reconfigure.value.clear_on_abort
      support_option_pd_exclude = reconfigure.value.support_option_pd_exclude
      timeout                   = reconfigure.value.timeout
      token                     = reconfigure.value.token
      trigger_radius_disconnect = reconfigure.value.trigger_radius_disconnect
    }
  }

  remote_id_mismatch_disconnect           = each.value.remote_id_mismatch_disconnect
  route_suppression_access                = each.value.route_suppression_access
  route_suppression_access_internal       = each.value.route_suppression_access_internal
  route_suppression_destination           = each.value.route_suppression_destination
  service_profile                         = each.value.service_profile
  short_cycle_protection_lockout_max_time = each.value.short_cycle_protection_lockout_max_time
  short_cycle_protection_lockout_min_time = each.value.short_cycle_protection_lockout_min_time
}
