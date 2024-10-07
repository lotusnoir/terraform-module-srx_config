##################################################################################
variable "security" {
  type = object({

    alg = optional(object({
    }))

    flow = optional(object({
      advanced_options = optional(object({
        drop_matching_link_local_address  = optional(bool)
        drop_matching_reserved_ip_address = optional(bool)
        reverse_route_packet_mode_vr      = optional(bool)
      }))
      aging = optional(object({
        early_ageout   = optional(number)
        high_watermark = optional(bool)
        low_watermark  = optional(bool)
      }))
      allow_dns_reply                       = optional(bool)
      allow_embedded_icmp                   = optional(bool)
      allow_reverse_ecmp                    = optional(bool)
      enable_reroute_uniform_link_check_nat = optional(bool)
      ethernet_switching = optional(object({
        block_non_ip_all      = optional(bool)
        bypass_non_ip_unicast = optional(bool)
        bpdu_vlan_flooding    = optional(bool)
        no_packet_flooding    = optional(bool)
      }))
      force_ip_reassembly             = optional(bool)
      ipsec_performance_acceleration  = optional(bool)
      mcast_buffer_enhance            = optional(bool)
      pending_sess_queue_length       = optional(string)
      preserve_incoming_fragment_size = optional(bool)
      route_change_timeout            = optional(number)
      syn_flood_protection_mode       = optional(string)
      sync_icmp_session               = optional(bool)
      tcp_mss = optional(object({
        all_tcp_mss = optional(number)
        gre_in      = optional(number)
        gre_out     = optional(number)
        ipsec_vpn   = optional(number)
      }))
      tcp_session = optional(object({
        fin_invalidate_session = optional(bool)
        maximum_window         = optional(string)
        no_sequence_check      = optional(bool)
        no_syn_check           = optional(bool)
        no_syn_check_in_tunnel = optional(bool)
        rst_invalidate_session = optional(bool)
        rst_sequence_check     = optional(bool)
        strict_syn_check       = optional(bool)
        tcp_initial_timeout    = optional(number)
        time_wait_state = optional(object({
          apply_to_half_close_state = optional(bool)
          session_ageout            = optional(bool)
          session_timeout           = optional(number)
        }))
      }))
    }))
    forwarding_options = optional(object({
    }))

    forwarding_process = optional(object({
    }))

    idp_security_package = optional(object({
    }))

    idp_sensor_configuration = optional(object({
    }))

    ike_traceoptions = optional(object({
    }))

    log = optional(object({
      disable           = optional(bool)
      event_rate        = optional(number)
      facility_override = optional(string)
      file = optional(object({
        files = optional(number)
        name  = optional(string)
        path  = optional(string)
        size  = optional(number)
      }))
      format              = optional(string)
      max_database_record = optional(number)
      mode                = optional(string)
      rate_cap            = optional(number)
      report              = optional(bool)
      source_address      = optional(string)
      source_interface    = optional(string)
      transport = optional(object({
        protocol        = optional(string)
        tcp_connections = optional(number)
        tls_profile     = optional(string)
      }))
      utc_timestamp = optional(bool)
    }))

    nat_source = optional(object({
    }))

    policies = optional(object({
    }))

    user_identification_auth_source = optional(object({
    }))

    utm = optional(object({
    }))


    #        external_severity            = optional(string)
    #        firewall_severity            = optional(string)
    #        ftp_severity                 = optional(string)
    #        interactivecommands_severity = optional(string)
    #        kernel_severity              = optional(string)
    #        ntp_severity                 = optional(string)
    #        pfe_severity                 = optional(string)
    #        security_severity            = optional(string)
    #        user_severity                = optional(string)
    #      }))
    #      log_rotate_frequency    = optional(number)
    #      source_address          = optional(string)
    #      time_format_millisecond = optional(bool)
    #      time_format_year        = optional(bool)
    #    }))
    #    tacplus_options_authorization_time_interval = optional(number)
    #    tacplus_options_enhanced_accounting         = optional(bool)
    #    tacplus_options_exclude_cmd_attribute       = optional(bool)
    #    tacplus_options_no_cmd_attribute_value      = optional(bool)
    #    tacplus_options_service_name                = optional(string)
    #    tacplus_options_strict_authorization        = optional(bool)
    #    tacplus_options_no_strict_authorization     = optional(bool)
    #    tacplus_options_timestamp_and_timezone      = optional(bool)
    #    time_zone                                   = optional(string)
    #    tracing_dest_override_syslog_host           = optional(string)
  })
  default = null
}


##################################################################################
resource "junos_security" "this" {
  count = var.security != null ? 1 : 0

  dynamic "flow" {
    for_each = var.security.flow != null ? [var.security.flow] : []
    content {
      dynamic "advanced_options" {
        for_each = flow.value.advanced_options != null ? [flow.value.advanced_options] : []
        content {
          drop_matching_link_local_address  = advanced_options.value.drop_matching_link_local_address
          drop_matching_reserved_ip_address = advanced_options.value.drop_matching_reserved_ip_address
          reverse_route_packet_mode_vr      = advanced_options.value.reverse_route_packet_mode_vr
        }
      }
      dynamic "aging" {
        for_each = flow.value.aging != null ? [flow.value.aging] : []
        content {
          early_ageout   = aging.value.early_ageout
          high_watermark = aging.value.high_watermark
          low_watermark  = aging.value.low_watermark
        }
      }
      allow_dns_reply                       = flow.value.allow_dns_reply
      allow_embedded_icmp                   = flow.value.allow_embedded_icmp
      allow_reverse_ecmp                    = flow.value.allow_reverse_ecmp
      enable_reroute_uniform_link_check_nat = flow.value.enable_reroute_uniform_link_check_nat
      dynamic "ethernet_switching" {
        for_each = flow.value.ethernet_switching != null ? [flow.value.ethernet_switching] : []
        content {
          block_non_ip_all      = ethernet_switching.value.block_non_ip_all
          bypass_non_ip_unicast = ethernet_switching.value.bypass_non_ip_unicast
          bpdu_vlan_flooding    = ethernet_switching.value.bpdu_vlan_flooding
          #no_packet_flooding    = ethernet_switching.value.no_packet_flooding
        }
      }
      force_ip_reassembly             = flow.value.force_ip_reassembly
      ipsec_performance_acceleration  = flow.value.ipsec_performance_acceleration
      mcast_buffer_enhance            = flow.value.mcast_buffer_enhance
      pending_sess_queue_length       = flow.value.pending_sess_queue_length
      preserve_incoming_fragment_size = flow.value.preserve_incoming_fragment_size
      route_change_timeout            = flow.value.route_change_timeout
      syn_flood_protection_mode       = flow.value.syn_flood_protection_mode
      sync_icmp_session               = flow.value.sync_icmp_session
      dynamic "tcp_mss" {
        for_each = flow.value.tcp_mss != null ? [flow.value.tcp_mss] : []
        content {
          all_tcp_mss = tcp_mss.value.all_tcp_mss
        }
      }
      dynamic "tcp_session" {
        for_each = flow.value.tcp_session != null ? [flow.value.tcp_session] : []
        content {
          fin_invalidate_session = tcp_session.value.fin_invalidate_session
          maximum_window         = tcp_session.value.maximum_window
          no_sequence_check      = tcp_session.value.no_sequence_check
          no_syn_check           = tcp_session.value.no_syn_check
          no_syn_check_in_tunnel = tcp_session.value.no_syn_check_in_tunnel
          rst_invalidate_session = tcp_session.value.rst_invalidate_session
          rst_sequence_check     = tcp_session.value.rst_sequence_check
          strict_syn_check       = tcp_session.value.strict_syn_check
          tcp_initial_timeout    = tcp_session.value.tcp_initial_timeout

          dynamic "time_wait_state" {
            for_each = tcp_session.value.time_wait_state != null ? [tcp_session.value.time_wait_state] : []
            content {
              apply_to_half_close_state = time_wait_state.value.apply_to_half_close_state
              session_ageout            = time_wait_state.value.session_ageout
              session_timeout           = time_wait_state.value.session_timeout
            }
          }
        }
      }
    }
  }



  dynamic "log" {
    for_each = var.security.log != null ? [var.security.log] : []
    content {
      disable           = log.value.disable
      event_rate        = log.value.event_rate
      facility_override = log.value.facility_override
      dynamic "file" {
        for_each = log.value.file != null ? [log.value.file] : []
        content {
          files = file.value.files
          name  = file.value.name
          path  = file.value.path
          size  = file.value.size
        }
      }
      format              = log.value.format
      max_database_record = log.value.max_database_record
      mode                = log.value.mode
      rate_cap            = log.value.rate_cap
      report              = log.value.report
      source_address      = log.value.source_address
      source_interface    = log.value.source_interface
      dynamic "transport" {
        for_each = log.value.transport != null ? [log.value.transport] : []
        content {
          protocol        = transport.value.protocol
          tcp_connections = transport.value.tcp_connections
          tls_profile     = transport.value.tls_profile
        }
      }
      utc_timestamp = log.value.utc_timestamp
    }
  }





}
