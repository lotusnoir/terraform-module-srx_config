#################################################################################################
variable "security_zones" {
  type = map(object({
    advance_policy_based_routing_profile = optional(bool)
    application_tracking                 = optional(bool)
    description                          = optional(string)
    inbound_protocols                    = optional(set(string))
    inbound_services                     = optional(set(string))
    reverse_reroute                      = optional(bool)
    screen                               = optional(string)
    source_identity_log                  = optional(bool)
    tcp_rst                              = optional(bool)
  }))
  default = {}
}


#################################################################################################
# set security zones security-zone xxxxxxxxx host-inbound-traffic system-services ping
#we consider that addresse-book shouldnt be declare here so address_book_* are absent
resource "junos_security_zone" "this" {
  for_each = var.security_zones

  name                                 = each.key
  advance_policy_based_routing_profile = each.value.advance_policy_based_routing_profile
  application_tracking                 = each.value.application_tracking
  description                          = each.value.description
  inbound_protocols                    = each.value.inbound_protocols != null ? each.value.inbound_protocols : null
  inbound_services                     = each.value.inbound_services != null ? each.value.inbound_services : null
  reverse_reroute                      = each.value.reverse_reroute
  screen                               = each.value.screen
  source_identity_log                  = each.value.source_identity_log
  tcp_rst                              = each.value.tcp_rst
}
