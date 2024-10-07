#################################################################################################
variable "bgp_group" {
  type = map(map(object({
    #name                           = string
    routing_instance               = optional(string)
    type                           = optional(string)
    accept_remote_nexthop          = optional(bool)
    advertise_external             = optional(bool)
    advertise_external_conditional = optional(bool)
    advertise_inactive             = optional(bool)
    advertise_peer_as              = optional(bool)
    no_advertise_peer_as           = optional(bool)
    as_override                    = optional(bool)
    authentication_algorithm       = optional(string)
    authentication_key             = optional(string)
    authentication_key_chain       = optional(string)
    bfd_liveness_detection = optional(object({
      authentication_algorithm           = optional(string)
      authentication_key_chain           = optional(string)
      authentication_loose_check         = optional(bool)
      detection_time_threshold           = optional(number)
      holddown_interval                  = optional(number)
      minimum_interval                   = optional(number)
      minimum_receive_interval           = optional(number)
      multiplier                         = optional(number)
      session_mode                       = optional(string)
      transmit_interval_minimum_interval = optional(number)
      transmit_interval_threshold        = optional(number)
      version                            = optional(string)
    }))
    bgp_error_tolerance = optional(object({
      malformed_route_limit         = optional(number)
      malformed_update_log_interval = optional(number)
      no_malformed_route_limit      = optional(bool)
    }))
    bgp_multipath = optional(object({
      allow_protection = optional(bool)
      disable          = optional(bool)
      multiple_as      = optional(bool)
    }))
    cluster     = optional(string)
    damping     = optional(bool)
    description = optional(string)
    export      = optional(list(string))
    family_evpn = optional(object({
      nlri_type = optional(string)
    }))
    family_inet = optional(object({
      nlri_type = string
      accepted_prefix_limit = optional(object({
        maximum                       = number
        teardown                      = optional(number)
        teardown_idle_timeout         = optional(number)
        teardown_idle_timeout_forever = optional(bool)
      }))
      #prefix_limit = optional(string)
    }))
    family_inet6 = optional(object({
      nlri_type = string
      accepted_prefix_limit = optional(object({
        maximum                       = number
        teardown                      = optional(number)
        teardown_idle_timeout         = optional(number)
        teardown_idle_timeout_forever = optional(bool)
      }))
      #prefix_limit = optional(string)
    }))
    graceful_restart = optional(object({
      disable          = optional(bool)
      restart_time     = optional(number)
      stale_route_time = optional(number)
    }))
    hold_time                       = optional(number)
    import                          = optional(list(string))
    keep_all                        = optional(bool)
    keep_none                       = optional(bool)
    local_address                   = optional(string)
    local_as                        = optional(string)
    local_as_alias                  = optional(bool)
    local_as_loops                  = optional(number)
    local_as_no_prepend_global_as   = optional(bool)
    local_as_private                = optional(bool)
    local_interface                 = optional(string)
    local_preference                = optional(number)
    log_updown                      = optional(bool)
    metric_out                      = optional(number)
    metric_out_igp                  = optional(bool)
    metric_out_igp_offset           = optional(number)
    metric_out_igp_delay_med_update = optional(bool)
    metric_out_minimum_igp          = optional(bool)
    metric_out_minimum_igp_offset   = optional(number)
    mtu_discovery                   = optional(bool)
    multihop                        = optional(bool)
    no_client_reflect               = optional(bool)
    out_delay                       = optional(number)
    passive                         = optional(bool)
    peer_as                         = optional(string)
    preference                      = optional(number)
    remove_private                  = optional(bool)
    tcp_aggressive_transmission     = optional(bool)
  })))
  default = {}
}


#################################################################################################
### OK
resource "junos_bgp_group" "this" {
  # for_each = var.bgp_group != null ? var.bgp_group : null
  for_each = local.flattened_bgp_group

  name             = each.value.name
  routing_instance = each.value.routing_instance

  type                           = each.value.content.type
  accept_remote_nexthop          = each.value.content.accept_remote_nexthop
  advertise_external             = each.value.content.advertise_external
  advertise_external_conditional = each.value.content.advertise_external_conditional
  advertise_inactive             = each.value.content.advertise_inactive
  advertise_peer_as              = each.value.content.advertise_peer_as
  no_advertise_peer_as           = each.value.content.no_advertise_peer_as
  as_override                    = each.value.content.as_override
  authentication_algorithm       = each.value.content.authentication_algorithm
  authentication_key             = each.value.content.authentication_key
  authentication_key_chain       = each.value.content.authentication_key_chain

  dynamic "bfd_liveness_detection" {
    for_each = each.value.content.bfd_liveness_detection != null ? [each.value.content.bfd_liveness_detection] : []
    content {
      authentication_algorithm           = bfd_liveness_detection.value.authentication_algorithm
      authentication_key_chain           = bfd_liveness_detection.value.authentication_key_chain
      authentication_loose_check         = bfd_liveness_detection.value.authentication_loose_check
      detection_time_threshold           = bfd_liveness_detection.value.detection_time_threshold
      holddown_interval                  = bfd_liveness_detection.value.holddown_interval
      minimum_interval                   = bfd_liveness_detection.value.minimum_interval
      minimum_receive_interval           = bfd_liveness_detection.value.minimum_receive_interval
      multiplier                         = bfd_liveness_detection.value.multiplier
      session_mode                       = bfd_liveness_detection.value.session_mode
      transmit_interval_minimum_interval = bfd_liveness_detection.value.transmit_interval_minimum_interval
      transmit_interval_threshold        = bfd_liveness_detection.value.transmit_interval_threshold
      version                            = bfd_liveness_detection.value.version
    }
  }

  dynamic "bgp_error_tolerance" {
    for_each = each.value.content.bgp_error_tolerance != null ? [each.value.content.bgp_error_tolerance] : []
    content {
      malformed_route_limit         = bgp_error_tolerance.value.malformed_route_limit
      malformed_update_log_interval = bgp_error_tolerance.value.malformed_update_log_interval
      no_malformed_route_limit      = bgp_error_tolerance.value.no_malformed_route_limit
    }
  }

  dynamic "bgp_multipath" {
    for_each = each.value.content.bgp_multipath != null ? [each.value.content.bgp_multipath] : []
    content {
      allow_protection = bgp_multipath.value.allow_protection
      disable          = bgp_multipath.value.disable
      multiple_as      = bgp_multipath.value.multiple_as
    }
  }

  cluster     = each.value.content.cluster
  damping     = each.value.content.damping
  description = each.value.content.description
  export      = each.value.content.export

  dynamic "family_evpn" {
    for_each = each.value.content.family_evpn != null ? [each.value.content.family_evpn] : []
    content {
      nlri_type = family_evpn.value.nlri_type
    }
  }

  dynamic "family_inet" {
    for_each = each.value.content.family_inet != null ? [each.value.content.family_inet] : []
    content {
      nlri_type = family_inet.value.nlri_type
      dynamic "accepted_prefix_limit" {
        for_each = each.value.content.accepted_prefix_limit != null ? [each.value.content.accepted_prefix_limit] : []
        content {
          maximum                       = accepted_prefix_limit.value.maximum
          teardown                      = accepted_prefix_limit.value.teardown
          teardown_idle_timeout         = accepted_prefix_limit.value.teardown_idle_timeout
          teardown_idle_timeout_forever = accepted_prefix_limit.value.teardown_idle_timeout_forever
        }
      }
    }
  }

  dynamic "family_inet6" {
    for_each = each.value.content.family_inet6 != null ? [each.value.content.family_inet6] : []
    content {
      nlri_type = family_init6.value.nlri_type
      dynamic "accepted_prefix_limit" {
        for_each = each.value.content.accepted_prefix_limit != null ? [each.value.content.accepted_prefix_limit] : []
        content {
          maximum                       = accepted_prefix_limit.value.maximum
          teardown                      = accepted_prefix_limit.value.teardown
          teardown_idle_timeout         = accepted_prefix_limit.value.teardown_idle_timeout
          teardown_idle_timeout_forever = accepted_prefix_limit.value.teardown_idle_timeout_forever
        }
      }
    }
  }

  dynamic "graceful_restart" {
    for_each = each.value.content.graceful_restart != null ? [each.value.content.graceful_restart] : []
    content {
      disable          = graceful_restart.value.disable
      restart_time     = graceful_restart.value.restart_time
      stale_route_time = graceful_restart.value.stale_route_time
    }
  }

  hold_time                       = each.value.content.hold_time
  import                          = each.value.content.import
  keep_all                        = each.value.content.keep_all
  keep_none                       = each.value.content.keep_none
  local_address                   = each.value.content.local_address
  local_as                        = each.value.content.local_as
  local_as_alias                  = each.value.content.local_as_alias
  local_as_loops                  = each.value.content.local_as_loops
  local_as_no_prepend_global_as   = each.value.content.local_as_no_prepend_global_as
  local_as_private                = each.value.content.local_as_private
  local_interface                 = each.value.content.local_interface
  local_preference                = each.value.content.local_preference
  log_updown                      = each.value.content.log_updown
  metric_out                      = each.value.content.metric_out
  metric_out_igp                  = each.value.content.metric_out_igp
  metric_out_igp_offset           = each.value.content.metric_out_igp_offset
  metric_out_igp_delay_med_update = each.value.content.metric_out_igp_delay_med_update
  metric_out_minimum_igp          = each.value.content.metric_out_minimum_igp
  metric_out_minimum_igp_offset   = each.value.content.metric_out_minimum_igp_offset
  mtu_discovery                   = each.value.content.mtu_discovery
  multihop                        = each.value.content.multihop
  no_client_reflect               = each.value.content.no_client_reflect
  out_delay                       = each.value.content.out_delay
  passive                         = each.value.content.passive
  peer_as                         = each.value.content.peer_as
  preference                      = each.value.content.preference
  remove_private                  = each.value.content.remove_private
  tcp_aggressive_transmission     = each.value.content.tcp_aggressive_transmission
}
