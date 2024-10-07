#################################################################################################
variable "bgp_neighbor" {
  type = map(object({
    ip                             = optional(string)
    routing_instance               = optional(string)
    group                          = optional(string)
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
      authentication_loose_check         = optional(number)
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
    cluster                         = optional(string)
    damping                         = optional(bool)
    description                     = optional(string)
    export                          = optional(list(string))
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
    metric_out_igp_delay_med_update = optional(bool)
    metric_out_igp_offset           = optional(number)
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
  }))
  default = {}
}


#################################################################################################
### OK
resource "junos_bgp_neighbor" "this" {
  depends_on = [junos_bgp_group.this]
  for_each   = var.bgp_neighbor != null ? var.bgp_neighbor : null

  ip                             = each.key
  routing_instance               = each.value.routing_instance
  group                          = each.value.group
  accept_remote_nexthop          = each.value.accept_remote_nexthop
  advertise_external             = each.value.advertise_external
  advertise_external_conditional = each.value.advertise_external_conditional
  advertise_inactive             = each.value.advertise_inactive
  advertise_peer_as              = each.value.advertise_peer_as
  no_advertise_peer_as           = each.value.no_advertise_peer_as
  as_override                    = each.value.as_override
  authentication_algorithm       = each.value.authentication_algorithm
  authentication_key             = each.value.authentication_key
  authentication_key_chain       = each.value.authentication_key_chain

  dynamic "bfd_liveness_detection" {
    for_each = each.value.bfd_liveness_detection != null ? [each.value.bfd_liveness_detection] : []
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
    for_each = each.value.bgp_error_tolerance != null ? [each.value.bgp_error_tolerance] : []
    iterator = bgp_error
    content {
      malformed_route_limit         = bgp_error.value.malformed_route_limit
      malformed_update_log_interval = bgp_error.value.malformed_update_log_interval
      no_malformed_route_limit      = bgp_error.value.no_malformed_route_limit
    }
  }

  dynamic "bgp_multipath" {
    for_each = each.value.bgp_multipath != null ? [each.value.bgp_multipath] : []
    content {
      allow_protection = bgp_multipath.value.allow_protection
      disable          = bgp_multipath.value.disable
      multiple_as      = bgp_multipath.value.multiple_as
    }
  }

  cluster                         = each.value.cluster
  damping                         = each.value.damping
  description                     = each.value.description
  export                          = each.value.export
  hold_time                       = each.value.hold_time
  import                          = each.value.import
  keep_all                        = each.value.keep_all
  keep_none                       = each.value.keep_none
  local_address                   = each.value.local_address
  local_as                        = each.value.local_as
  local_as_alias                  = each.value.local_as_alias
  local_as_loops                  = each.value.local_as_loops
  local_as_no_prepend_global_as   = each.value.local_as_no_prepend_global_as
  local_as_private                = each.value.local_as_private
  local_interface                 = each.value.local_interface
  local_preference                = each.value.local_preference
  log_updown                      = each.value.log_updown
  metric_out                      = each.value.metric_out
  metric_out_igp                  = each.value.metric_out_igp
  metric_out_igp_delay_med_update = each.value.metric_out_igp_delay_med_update
  metric_out_igp_offset           = each.value.metric_out_igp_offset
  metric_out_minimum_igp          = each.value.metric_out_minimum_igp
  metric_out_minimum_igp_offset   = each.value.metric_out_minimum_igp_offset
  mtu_discovery                   = each.value.mtu_discovery
  multihop                        = each.value.multihop
  no_client_reflect               = each.value.no_client_reflect
  out_delay                       = each.value.out_delay
  passive                         = each.value.passive
  peer_as                         = each.value.peer_as
  preference                      = each.value.preference
  remove_private                  = each.value.remove_private
  tcp_aggressive_transmission     = each.value.tcp_aggressive_transmission
}
