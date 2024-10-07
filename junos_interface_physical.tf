##################################################################################
variable "interfaces_physical" {
  type = map(object({
    no_disable_on_destroy = optional(bool)
    description           = optional(string)
    disable               = optional(bool)
    encapsulation         = optional(string)
    esi = optional(object({
      mode             = optional(string)
      auto_derive_lacp = optional(bool)
      df_election_type = optional(string)
      identifier       = optional(string)
      source_bmac      = optional(string)
    }))
    ether_opts = optional(object({
      ae_8023ad           = optional(string)
      auto_negotiation    = optional(bool)
      no_auto_negotiation = optional(bool)
      flow_control        = optional(bool)
      no_flow_control     = optional(bool)
      loopback            = optional(bool)
      no_loopback         = optional(bool)
      redundant_parent    = optional(string)
    }))
    flexible_vlan_tagging = optional(bool)
    gigether_opts = optional(object({
      ae_8023ad           = optional(string)
      auto_negotiation    = optional(bool)
      no_auto_negotiation = optional(bool)
      flow_control        = optional(bool)
      no_flow_control     = optional(bool)
      loopback            = optional(bool)
      no_loopback         = optional(bool)
      redundant_parent    = optional(string)
    }))
    gratuitous_arp_reply      = optional(bool)
    hold_time_down            = optional(number)
    hold_time_up              = optional(number)
    link_mode                 = optional(string)
    mtu                       = optional(number)
    no_gratuitous_arp_reply   = optional(bool)
    no_gratuitous_arp_request = optional(bool)
    parent_ether_opts = optional(object({
      bfd_liveness_detection = optional(object({
        local_address                      = optional(string)
        authentication_algorithm           = optional(string)
        authentication_key_chain           = optional(string)
        authentication_loose_check         = optional(bool)
        detection_time_threshold           = optional(number)
        holddown_interval                  = optional(number)
        minimum_interval                   = optional(number)
        minimum_receive_interval           = optional(number)
        multiplier                         = optional(number)
        neighbor                           = optional(string)
        no_adaptation                      = optional(bool)
        transmit_interval_minimum_interval = optional(number)
        transmit_interval_threshold        = optional(number)
        version                            = optional(string)
      }))
      flow_control    = optional(bool)
      no_flow_control = optional(bool)
      lacp = optional(object({
        mode            = optional(string)
        admin_key       = optional(number)
        periodic        = optional(string)
        sync_reset      = optional(string)
        system_id       = optional(string)
        system_priority = optional(number)
      }))
      loopback    = optional(bool)
      no_loopback = optional(bool)
      link_speed  = optional(string)
      mc_ae = optional(object({
        chassis_id           = optional(number)
        mc_ae_id             = optional(number)
        mode                 = optional(string)
        status_control       = optional(string)
        enhanced_convergence = optional(bool)
        init_delay_time      = optional(number)
        redundancy_group     = optional(number)
        revert_time          = optional(number)
        switchover_mode      = optional(string)
      }))
      minimum_bandwidth     = optional(string)
      minimum_links         = optional(number)
      redundancy_group      = optional(number)
      source_address_filter = optional(list(string))
      source_filtering      = optional(bool)
    }))
    speed               = optional(string)
    storm_control       = optional(string)
    trunk               = optional(bool)
    trunk_non_els       = optional(bool)
    vlan_members        = optional(set(string))
    vlan_native         = optional(number)
    vlan_native_non_els = optional(string)
    vlan_tagging        = optional(bool)
  }))
  default = {}
}


##################################################################################
resource "junos_interface_physical" "this" {
  for_each = var.interfaces_physical

  name                  = each.key
  no_disable_on_destroy = each.value.no_disable_on_destroy
  description           = each.value.description
  disable               = each.value.disable
  encapsulation         = each.value.encapsulation

  dynamic "esi" {
    for_each = each.value.esi != null ? [each.value.esi] : []
    iterator = esi
    content {
      mode             = esi.value.mode
      auto_derive_lacp = esi.value.auto_derive_lacp
      df_election_type = esi.value.df_election_type
      identifier       = esi.value.identifier
      source_bmac      = esi.value.source_bmac
    }
  }

  dynamic "ether_opts" {
    for_each = each.value.ether_opts != null ? [each.value.ether_opts] : []
    iterator = ether
    content {
      ae_8023ad           = ether.value.ae_8023ad
      auto_negotiation    = ether.value.auto_negotiation
      no_auto_negotiation = ether.value.no_auto_negotiation
      flow_control        = ether.value.flow_control
      no_flow_control     = ether.value.no_flow_control
      loopback            = ether.value.loopback
      no_loopback         = ether.value.no_loopback
      redundant_parent    = ether.value.redundant_parent
    }
  }

  flexible_vlan_tagging = each.value.flexible_vlan_tagging

  dynamic "gigether_opts" {
    for_each = each.value.gigether_opts != null ? [each.value.gigether_opts] : []
    iterator = gigether
    content {
      ae_8023ad           = gigether.value.ae_8023ad
      auto_negotiation    = gigether.value.auto_negotiation
      no_auto_negotiation = gigether.value.no_auto_negotiation
      flow_control        = gigether.value.flow_control
      no_flow_control     = gigether.value.no_flow_control
      loopback            = gigether.value.loopback
      no_loopback         = gigether.value.no_loopback
      redundant_parent    = gigether.value.redundant_parent
    }
  }

  gratuitous_arp_reply      = each.value.gratuitous_arp_reply
  hold_time_down            = each.value.hold_time_down
  hold_time_up              = each.value.hold_time_up
  link_mode                 = each.value.link_mode
  mtu                       = each.value.mtu
  no_gratuitous_arp_reply   = each.value.no_gratuitous_arp_reply
  no_gratuitous_arp_request = each.value.no_gratuitous_arp_request

  dynamic "parent_ether_opts" {
    for_each = each.value.parent_ether_opts != null ? [each.value.parent_ether_opts] : []
    iterator = popts

    content {
      dynamic "bfd_liveness_detection" {
        for_each = popts.value.bfd_liveness_detection != null ? [popts.value.bfd_liveness_detection] : []
        iterator = bfd
        content {
          local_address                      = bfd.value.local_address
          authentication_algorithm           = bfd.value.authentication_algorithm
          authentication_key_chain           = bfd.value.authentication_key_chain
          authentication_loose_check         = bfd.value.authentication_loose_check
          detection_time_threshold           = bfd.value.detection_time_threshold
          holddown_interval                  = bfd.value.holddown_interval
          minimum_interval                   = bfd.value.minimum_interval
          minimum_receive_interval           = bfd.value.minimum_receive_interval
          multiplier                         = bfd.value.multiplier
          neighbor                           = bfd.value.neighbor
          no_adaptation                      = bfd.value.no_adaptation
          transmit_interval_minimum_interval = bfd.value.transmit_interval_minimum_interval
          transmit_interval_threshold        = bfd.value.transmit_interval_threshold
          version                            = bfd.value.version
        }
      }

      flow_control    = popts.value.flow_control
      no_flow_control = popts.value.no_flow_control

      dynamic "lacp" {
        for_each = popts.value.lacp != null ? [popts.value.lacp] : []
        iterator = lacp
        content {
          mode            = lacp.value.mode
          admin_key       = lacp.value.admin_key
          periodic        = lacp.value.periodic
          sync_reset      = lacp.value.sync_reset
          system_id       = lacp.value.system_id
          system_priority = lacp.value.system_priority
        }
      }

      loopback    = popts.value.loopback
      no_loopback = popts.value.no_loopback
      link_speed  = popts.value.link_speed

      dynamic "mc_ae" {
        for_each = popts.value.mc_ae != null ? [popts.value.mc_ae] : []
        iterator = mc
        content {
          chassis_id           = mc.value.chassis_id
          mc_ae_id             = mc.value.mc_ae_id
          mode                 = mc.value.mode
          status_control       = mc.value.status_control
          enhanced_convergence = mc.value.enhanced_convergence
          init_delay_time      = mc.value.init_delay_time
          redundancy_group     = mc.value.redundancy_group
          revert_time          = mc.value.revert_time
          switchover_mode      = mc.value.switchover_mode
        }
      }
      minimum_bandwidth     = popts.value.minimum_bandwidth
      minimum_links         = popts.value.minimum_links
      redundancy_group      = popts.value.redundancy_group
      source_address_filter = popts.value.source_address_filter
      source_filtering      = popts.value.source_filtering
    }
  }

  speed               = each.value.speed
  storm_control       = each.value.storm_control
  trunk               = each.value.trunk
  trunk_non_els       = each.value.trunk_non_els
  vlan_members        = each.value.vlan_members
  vlan_native         = each.value.vlan_native
  vlan_native_non_els = each.value.vlan_native_non_els
  vlan_tagging        = each.value.vlan_tagging
}
