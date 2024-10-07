##################################################################################
#variable "routing_options" {
#  type = map(object({
#    clean_on_destroy = optional(bool)
#    autonomous_system = optional(object({
#      number         = optional(string)
#      asdot_notation = optional(bool)
#      loops          = optional(number)
#    }))
#    forwarding_table = optional(object({
#      chain_composite_max_label_count              = optional(number)
#      chained_composite_next_hop_ingress           = optional(set(string))
#      chained_composite_next_hop_transit           = optional(set(string))
#      dynamic_list_next_hop                        = optional(bool)
#      ecmp_fast_reroute                            = optional(bool)
#      no_ecmp_fast_reroute                         = optional(bool)
#      export                                       = optional(list(string))
#      indirect_next_hop                            = optional(bool)
#      no_indirect_next_hop                         = optional(bool)
#      indirect_next_hop_change_acknowledgements    = optional(bool)
#      no_indirect_next_hop_change_acknowledgements = optional(bool)
#      krt_nexthop_ack_timeout                      = optional(number)
#      remnant_holdtime                             = optional(number)
#      unicast_reverse_path                         = optional(string)
#    }))
#    forwarding_table_export_configure_singly = optional(bool)
#    graceful_restart = optional(object({
#      disable          = optional(bool)
#      restart_duration = optional(number)
#    }))
#    instance_export = optional(list(string))
#    instance_import = optional(list(string))
#    router_id       = optional(string)
#  }))
#  default = {}
#}
