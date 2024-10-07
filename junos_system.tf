##################################################################################
### All options with v2.6.0 OK
###
variable "system" {
  type = object({
    accounting = optional(object({
      events             = optional(set(string))
      destination_radius = optional(bool)
      destination_radius_server = optional(object({
        address                  = optional(string)
        secret                   = optional(string)
        accounting_port          = optional(number)
        accounting_retry         = optional(number)
        accounting_timeout       = optional(number)
        dynamic_request_port     = optional(number)
        max_outstanding_request  = optional(number)
        port                     = optional(number)
        preauthentication_port   = optional(number)
        preauthentication_secret = optional(string)
        retry                    = optional(number)
        routing_instance         = optional(string)
        source_address           = optional(string)
        timeout                  = optional(number)
      }))
      destination_tacplus = optional(bool)
      destination_tacplus_server = optional(object({
        address           = string
        port              = optional(number)
        routing_instance  = optional(string)
        secret            = optional(string)
        single_connection = optional(bool)
        source_address    = optional(string)
        timeout           = optional(number)
      }))
      enhanced_avs_max = optional(number)
    }))
    archival_configuration = optional(object({
      archive_site = optional(object({
        url      = string
        password = optional(string)
      }))
      transfer_interval  = optional(number)
      transfer_on_commit = optional(bool)
    }))
    authentication_order      = optional(set(string))
    auto_snapshot             = optional(bool)
    default_address_selection = optional(bool)
    domain_name               = optional(string)
    host_name                 = optional(string)
    inet6_backup_router = optional(object({
      address     = optional(string)
      destination = optional(set(string))
    }))
    internet_options = optional(object({
      gre_path_mtu_discovery    = optional(bool)
      no_gre_path_mtu_discovery = optional(bool)
      icmpv4_rate_limit = optional(object({
        bucket_size = optional(number)
        packet-rate = optional(number)
      }))
      icmpv6_rate_limit = optional(object({
        bucket_size = optional(number)
        packet-rate = optional(number)
      }))
      ipip_path_mtu_discovery                 = optional(bool)
      no_ipip_path_mtu_discovery              = optional(bool)
      ipv6_duplicate_addr_detection_transmits = optional(number)
      ipv6_path_mtu_discovery                 = optional(bool)
      no_ipv6_path_mtu_discovery              = optional(bool)
      ipv6_path_mtu_discovery_timeout         = optional(number)
      ipv6_reject_zero_hop_limit              = optional(bool)
      no_ipv6_reject_zero_hop_limit           = optional(bool)
      no_tcp_reset                            = optional(bool)
      no_tcp_rfc1323                          = optional(bool)
      no_tcp_rfc1323_paws                     = optional(bool)
      path_mtu_discovery                      = optional(bool)
      no_path_mtu_discovery                   = optional(bool)
      source_port_upper_limit                 = optional(number)
      source_quench                           = optional(bool)
      no_source_quench                        = optional(bool)
      tcp_drop_synfin_set                     = optional(bool)
      tcp_mss                                 = optional(number)
    }))
    license = optional(object({
      autoupdate              = optional(bool)
      autoupdate_password     = optional(string)
      autoupdate_url          = optional(string)
      keys                    = optional(set(string))
      renew_before_expiration = optional(number)
      renew_interval          = optional(number)
    }))
    login = optional(object({
      announcement         = optional(string)
      deny_sources_address = optional(set(string))
      idle_timeout         = optional(number)
      message              = optional(string)
      password = optional(object({
        change_type               = optional(string)
        format                    = optional(string)
        maximum_length            = optional(number)
        minimum_changes           = optional(number)
        minimum_character_changes = optional(number)
        minimum_length            = optional(number)
        minimum_lower_cases       = optional(number)
        minimum_numerics          = optional(number)
        minimum_punctuations      = optional(number)
        minimum_reuse             = optional(number)
        minimum_upper_cases       = optional(number)
      }))
    }))
    max_configuration_rollbacks = optional(number)
    max_configurations_on_flash = optional(number)
    name_server                 = optional(set(string))
    name_server_opts = optional(object({
      address          = string
      routing_instance = optional(string)
    }))
    no_multicast_echo    = optional(bool)
    no_ping_record_route = optional(bool)
    no_ping_time_stamp   = optional(bool)
    no_redirects         = optional(bool)
    no_redirects_ipv6    = optional(bool)
    ntp = optional(object({
      boot_server              = optional(string)
      broadcast_client         = optional(bool)
      interval_range           = optional(number)
      multicast_client         = optional(bool)
      multicast_client_address = optional(string)
      threshold_action         = optional(string)
      threshold_value          = optional(number)
    }))
    ports = optional(object({
      auxiliary_authentication_order = optional(list(string))
      auxiliary_disable              = optional(bool)
      auxiliary_insecure             = optional(bool)
      auxiliary_logout_on_disconnect = optional(bool)
      auxiliary_type                 = optional(string)
      console_authentication_order   = optional(list(string))
      console_disable                = optional(bool)
      console_insecure               = optional(bool)
      console_logout_on_disconnect   = optional(bool)
      console_type                   = optional(string)
    }))
    radius_options_attributes_nas_id          = optional(string)
    radius_options_attributes_nas_ipaddress   = optional(string)
    radius_options_enhanced_accounting        = optional(bool)
    radius_options_password_protocol_mschapv2 = optional(bool)
    services = optional(object({
      netconf_ssh = optional(object({
        client_alive_count_max = optional(number)
        client_alive_interval  = optional(number)
        connection_limit       = optional(number)
        rate_limit             = optional(number)
      }))
      netconf_traceoptions = optional(object({
        file_name              = optional(string)
        file_files             = optional(number)
        file_match             = optional(string)
        file_size              = optional(number)
        file_world_readable    = optional(bool)
        file_no_world_readable = optional(bool)
        flag                   = optional(set(string))
        no_remote_trace        = optional(bool)
        on_demand              = optional(bool)
      }))
      ssh = optional(object({
        authentication_order           = optional(list(string))
        ciphers                        = optional(set(string))
        client_alive_count_max         = optional(number)
        client_alive_interval          = optional(number)
        connection_limit               = optional(number)
        fingerprint_hash               = optional(string)
        hostkey_algorithm              = optional(set(string))
        key_exchange                   = optional(set(string))
        log_key_changes                = optional(bool)
        macs                           = optional(set(string))
        max_pre_authentication_packets = optional(number)
        max_sessions_per_connection    = optional(number)
        no_passwords                   = optional(bool)
        no_public_keys                 = optional(bool)
        port                           = optional(number)
        protocol_version               = optional(set(string))
        rate_limit                     = optional(number)
        root_login                     = optional(string)
        tcp_forwarding                 = optional(bool)
        no_tcp_forwarding              = optional(bool)
      }))
      web_management_http = optional(object({
        interface = optional(string)
        port      = optional(number)
      }))
      web_management_https = optional(object({
        interface                    = optional(set(string))
        local_certificate            = optional(string)
        pki_local_certificate        = optional(string)
        port                         = optional(number)
        system_generated_certificate = optional(bool)
      }))
      web_management_session_idle_timeout = optional(number)
      web_management_session_limit        = optional(number)
    }))
    syslog = optional(object({
      archive = optional(object({
        binary_data    = optional(bool)
        files          = optional(number)
        size           = optional(number)
        world_readable = optional(bool)
      }))
      console = optional(object({
        any_severity                 = optional(string)
        authorization_severity       = optional(string)
        changelog_severity           = optional(string)
        conflictlog_severity         = optional(string)
        daemon_severity              = optional(string)
        dfc_severity                 = optional(string)
        external_severity            = optional(string)
        firewall_severity            = optional(string)
        ftp_severity                 = optional(string)
        interactivecommands_severity = optional(string)
        kernel_severity              = optional(string)
        ntp_severity                 = optional(string)
        pfe_severity                 = optional(string)
        security_severity            = optional(string)
        user_severity                = optional(string)
      }))
      log_rotate_frequency    = optional(number)
      source_address          = optional(string)
      time_format_millisecond = optional(bool)
      time_format_year        = optional(bool)
    }))
    tacplus_options_authorization_time_interval = optional(number)
    tacplus_options_enhanced_accounting         = optional(bool)
    tacplus_options_exclude_cmd_attribute       = optional(bool)
    tacplus_options_no_cmd_attribute_value      = optional(bool)
    tacplus_options_service_name                = optional(string)
    tacplus_options_strict_authorization        = optional(bool)
    tacplus_options_no_strict_authorization     = optional(bool)
    tacplus_options_timestamp_and_timezone      = optional(bool)
    time_zone                                   = optional(string)
    tracing_dest_override_syslog_host           = optional(string)
  })
  default = null
}


##################################################################################
### All options with v2.6.0 OK
resource "junos_system" "system" {
  count = var.system != null ? 1 : 0

  dynamic "accounting" {
    for_each = var.system.accounting != null ? [var.system.accounting] : []
    content {
      events             = accounting.value.events
      destination_radius = accounting.value.destination_radius
      dynamic "destination_radius_server" {
        for_each = var.system.accounting.destination_radius_server != null ? [1] : []
        iterator = item
        content {
          address                  = item.value.address
          secret                   = item.value.secret
          accounting_port          = item.value.accounting_port
          accounting_retry         = item.value.accounting_retry
          accounting_timeout       = item.value.accounting_timeout
          dynamic_request_port     = item.value.dynamic_request_port
          max_outstanding_requests = item.value.max_outstanding_requests
          port                     = item.value.port
          preauthentication_port   = item.value.preauthentication_port
          preauthentication_secret = item.value.preauthentication_secret
          retry                    = item.value.retry
          routing_instance         = item.value.routing_instance
          source_address           = item.value.source_address
          timeout                  = item.value.timeout
        }
      }
      destination_tacplus = accounting.value.destination_tacplus
      dynamic "destination_tacplus_server" {
        for_each = var.system.accounting.destination_tacplus_server != null ? [1] : []
        iterator = item
        content {
          address           = item.value.address
          port              = item.value.port
          routing_instance  = item.value.routing_instance
          secret            = item.value.secret
          single_connection = item.value.single_connection
          source_address    = item.value.source_address
          timeout           = item.value.timeout
        }
      }
      enhanced_avs_max = accounting.value.enhanced_avs_max
    }
  }


  dynamic "archival_configuration" {
    for_each = var.system.archival_configuration != null ? [var.system.archival_configuration] : []
    content {
      dynamic "archive_site" {
        for_each = var.system.archival_configuration.archive_site != null ? [1] : []
        iterator = item
        content {
          url      = item.value.url
          password = item.value.password
        }
      }
      transfer_interval  = archival_configuration.value.transfer_interval
      transfer_on_commit = archival_configuration.value.transfer_on_commit
    }
  }


  authentication_order      = var.system.authentication_order
  auto_snapshot             = var.system.auto_snapshot
  default_address_selection = var.system.default_address_selection
  domain_name               = var.system.domain_name
  host_name                 = var.system.host_name


  dynamic "inet6_backup_router" {
    for_each = var.system.inet6_backup_router != null ? [1] : []
    content {
      address     = inet6_backup_router.value.address
      destination = inet6_backup_router.value.destination
    }
  }

  dynamic "internet_options" {
    for_each = var.system.internet_options != null ? [var.system.internet_options] : []
    content {
      gre_path_mtu_discovery    = internet_options.value.gre_path_mtu_discovery
      no_gre_path_mtu_discovery = internet_options.value.no_gre_path_mtu_discovery
      dynamic "icmpv4_rate_limit" {
        for_each = var.system.internet_options.icmpv4_rate_limit != null ? [1] : []
        iterator = item
        content {
          bucket_size = item.value.bucket_size
          packet_rate = item.value.packet-rate
        }
      }
      dynamic "icmpv6_rate_limit" {
        for_each = var.system.internet_options.icmpv6_rate_limit != null ? [1] : []
        iterator = item
        content {
          bucket_size = item.value.bucket_size
          packet_rate = item.value.packet-rate
        }
      }
      ipip_path_mtu_discovery                 = internet_options.value.ipip_path_mtu_discovery
      no_ipip_path_mtu_discovery              = internet_options.value.no_ipip_path_mtu_discovery
      ipv6_duplicate_addr_detection_transmits = internet_options.value.ipv6_duplicate_addr_detection_transmits
      ipv6_path_mtu_discovery                 = internet_options.value.ipv6_path_mtu_discovery
      no_ipv6_path_mtu_discovery              = internet_options.value.no_ipv6_path_mtu_discovery
      ipv6_path_mtu_discovery_timeout         = internet_options.value.ipv6_path_mtu_discovery_timeout
      ipv6_reject_zero_hop_limit              = internet_options.value.ipv6_reject_zero_hop_limit
      no_ipv6_reject_zero_hop_limit           = internet_options.value.no_ipv6_reject_zero_hop_limit
      no_tcp_reset                            = internet_options.value.no_tcp_reset
      no_tcp_rfc1323                          = internet_options.value.no_tcp_rfc1323
      no_tcp_rfc1323_paws                     = internet_options.value.no_tcp_rfc1323_paws
      path_mtu_discovery                      = internet_options.value.path_mtu_discovery
      no_path_mtu_discovery                   = internet_options.value.no_path_mtu_discovery
      source_port_upper_limit                 = internet_options.value.source_port_upper_limit
      source_quench                           = internet_options.value.source_quench
      no_source_quench                        = internet_options.value.no_source_quench
      tcp_drop_synfin_set                     = internet_options.value.tcp_drop_synfin_set
      tcp_mss                                 = internet_options.value.tcp_mss
    }
  }


  dynamic "license" {
    for_each = var.system.license != null ? [var.system.license] : []
    content {
      autoupdate              = license.value.autoupdate
      autoupdate_password     = license.value.autoupdate_password
      autoupdate_url          = license.value.autoupdate_url
      keys                    = license.value.keys
      renew_before_expiration = license.value.renew_before_expiration
      renew_interval          = license.value.renew_interval
    }
  }


  dynamic "login" {
    for_each = var.system.login != null ? [var.system.login] : []
    content {
      announcement         = login.value.announcement
      deny_sources_address = login.value.deny_sources_address
      idle_timeout         = login.value.idle_timeout
      message              = login.value.message
      dynamic "password" {
        for_each = var.system.login.password != null ? [1] : []
        iterator = item
        content {
          change_type               = item.value.change_type
          format                    = item.value.format
          maximum_length            = item.value.maximum_length
          minimum_changes           = item.value.minimum_changes
          minimum_character_changes = item.value.minimum_character_changes
          minimum_length            = item.value.minimum_length
          minimum_lower_cases       = item.value.minimum_lower_cases
          minimum_numerics          = item.value.minimum_numerics
          minimum_punctuations      = item.value.minimum_punctuations
          minimum_reuse             = item.value.minimum_reuse
          minimum_upper_cases       = item.value.minimum_upper_cases
        }
      }
    }
  }

  max_configuration_rollbacks = var.system.max_configuration_rollbacks
  max_configurations_on_flash = var.system.max_configurations_on_flash
  name_server                 = var.system.name_server

  dynamic "name_server_opts" {
    for_each = var.system.name_server_opts != null ? [1] : []
    content {
      address          = name_server_opts.value.address
      routing_instance = name_server_opts.value.routing_instance
    }
  }

  no_multicast_echo    = var.system.no_multicast_echo
  no_ping_record_route = var.system.no_ping_record_route
  no_ping_time_stamp   = var.system.no_ping_time_stamp
  no_redirects         = var.system.no_redirects
  no_redirects_ipv6    = var.system.no_redirects_ipv6


  dynamic "ntp" {
    for_each = var.system.ntp != null ? [1] : []
    content {
      boot_server              = ntp.value.boot_server
      broadcast_client         = ntp.value.broadcast_client
      interval_range           = ntp.value.interval_range
      multicast_client         = ntp.value.multicast_client
      multicast_client_address = ntp.value.multicast_client_address
      threshold_action         = ntp.value.threshold_action
      threshold_value          = ntp.value.threshold_value
    }
  }


  dynamic "ports" {
    for_each = var.system.ports != null ? [1] : []
    content {
      auxiliary_authentication_order = ports.value.auxiliary_authentication_order
      auxiliary_disable              = ports.value.auxiliary_disable
      auxiliary_insecure             = ports.value.auxiliary_insecure
      auxiliary_logout_on_disconnect = ports.value.auxiliary_logout_on_disconnect
      auxiliary_type                 = ports.value.auxiliary_type
      console_authentication_order   = ports.value.console_authentication_order
      console_disable                = ports.value.console_disable
      console_insecure               = ports.value.console_insecure
      console_logout_on_disconnect   = ports.value.console_logout_on_disconnect
      console_type                   = ports.value.console_type
    }
  }


  radius_options_attributes_nas_id          = var.system.radius_options_attributes_nas_id
  radius_options_attributes_nas_ipaddress   = var.system.radius_options_attributes_nas_ipaddress
  radius_options_enhanced_accounting        = var.system.radius_options_enhanced_accounting
  radius_options_password_protocol_mschapv2 = var.system.radius_options_password_protocol_mschapv2


  dynamic "services" {
    for_each = var.system.services != null ? [1] : []
    content {
      dynamic "netconf_ssh" {
        for_each = var.system.services.netconf_ssh != null ? [var.system.services.netconf_ssh] : []
        iterator = item
        content {
          client_alive_count_max = item.value.client_alive_count_max
          client_alive_interval  = item.value.client_alive_interval
          connection_limit       = item.value.connection_limit
          rate_limit             = item.value.rate_limit
        }
      }
      dynamic "netconf_traceoptions" {
        for_each = var.system.services.netconf_traceoptions != null ? [var.system.services.netconf_traceoptions] : []
        iterator = item
        content {
          #file_no_world_readable = ssh.value.file_no_world_readable
          file_name           = item.value.file_name
          file_files          = item.value.file_files
          file_match          = item.value.file_match
          file_size           = item.value.file_size
          file_world_readable = item.value.file_world_readable
          flag                = item.value.flag
          no_remote_trace     = item.value.no_remote_trace
          on_demand           = item.value.on_demand
        }
      }
      dynamic "ssh" {
        for_each = var.system.services.ssh != null ? [var.system.services.ssh] : []
        content {
          authentication_order           = ssh.value.authentication_order
          ciphers                        = ssh.value.ciphers
          client_alive_count_max         = ssh.value.client_alive_count_max
          client_alive_interval          = ssh.value.client_alive_interval
          connection_limit               = ssh.value.connection_limit
          fingerprint_hash               = ssh.value.fingerprint_hash
          hostkey_algorithm              = ssh.value.hostkey_algorithm
          key_exchange                   = ssh.value.key_exchange
          log_key_changes                = ssh.value.log_key_changes
          macs                           = ssh.value.macs
          max_pre_authentication_packets = ssh.value.max_pre_authentication_packets
          max_sessions_per_connection    = ssh.value.max_sessions_per_connection
          no_passwords                   = ssh.value.no_passwords
          no_public_keys                 = ssh.value.no_public_keys
          port                           = ssh.value.port
          protocol_version               = ssh.value.protocol_version
          rate_limit                     = ssh.value.rate_limit
          root_login                     = ssh.value.root_login
          tcp_forwarding                 = ssh.value.tcp_forwarding
          no_tcp_forwarding              = ssh.value.no_tcp_forwarding
        }
      }
      dynamic "web_management_http" {
        for_each = var.system.services.web_management_http != null ? [var.system.services.web_management_http] : []
        iterator = item
        content {
          interface = item.value.client_alive_count_max
          port      = item.value.rate_limit
        }
      }
      dynamic "web_management_https" {
        for_each = var.system.services.web_management_https != null ? [var.system.services.web_management_https] : []
        iterator = item
        content {
          #local_certificate            = item.value.local_certificate
          #pki_local_certificate        = item.value.pki_local_certificate
          interface                    = item.value.interface
          port                         = item.value.port
          system_generated_certificate = item.value.system_generated_certificate
        }
      }
      web_management_session_idle_timeout = var.system.services.web_management_session_idle_timeout
      web_management_session_limit        = var.system.services.web_management_session_limit
    }
  }


  dynamic "syslog" {
    for_each = var.system.syslog != null ? [var.system.syslog] : []
    content {
      dynamic "archive" {
        for_each = var.system.syslog.archive != null ? [var.system.syslog.archive] : []
        content {
          binary_data    = archive.value.binary_data
          files          = archive.value.files
          size           = archive.value.size
          world_readable = archive.value.world_readable
        }
      }
      dynamic "console" {
        for_each = var.system.syslog.console != null ? [var.system.syslog.console] : []
        content {
          any_severity                 = console.value.any_severity
          authorization_severity       = console.value.authorization_severity
          changelog_severity           = console.value.changelog_severity
          conflictlog_severity         = console.value.conflictlog_severity
          daemon_severity              = console.value.daemon_severity
          dfc_severity                 = console.value.dfc_severity
          external_severity            = console.value.external_severity
          firewall_severity            = console.value.firewall_severity
          ftp_severity                 = console.value.ftp_severity
          interactivecommands_severity = console.value.interactivecommands_severity
          kernel_severity              = console.value.kernel_severity
          ntp_severity                 = console.value.ntp_severity
          pfe_severity                 = console.value.pfe_severity
          security_severity            = console.value.security_severity
          user_severity                = console.value.user_severity
        }
      }
      log_rotate_frequency    = syslog.value.log_rotate_frequency
      source_address          = syslog.value.source_address
      time_format_millisecond = syslog.value.time_format_millisecond
      time_format_year        = syslog.value.time_format_year
    }
  }

  tacplus_options_authorization_time_interval = var.system.tacplus_options_authorization_time_interval
  tacplus_options_enhanced_accounting         = var.system.tacplus_options_enhanced_accounting
  tacplus_options_exclude_cmd_attribute       = var.system.tacplus_options_exclude_cmd_attribute
  tacplus_options_no_cmd_attribute_value      = var.system.tacplus_options_no_cmd_attribute_value
  tacplus_options_service_name                = var.system.tacplus_options_service_name
  tacplus_options_strict_authorization        = var.system.tacplus_options_strict_authorization
  tacplus_options_no_strict_authorization     = var.system.tacplus_options_no_strict_authorization
  tacplus_options_timestamp_and_timezone      = var.system.tacplus_options_timestamp_and_timezone
  time_zone                                   = var.system.time_zone
  tracing_dest_override_syslog_host           = var.system.tracing_dest_override_syslog_host
}
