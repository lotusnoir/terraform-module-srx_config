##################################################################################
variable "chassis_cluster" {
  type = object({
    fab0 = object({
      member_interfaces = optional(list(string))
      description       = optional(string)
    })
    fab1 = optional(object({
      member_interfaces = optional(list(string))
      description       = optional(string)
    }))
    redundancy_group = list(object({
      node0_priority       = number
      node1_priority       = number
      gratuitous_arp_count = optional(number)
      hold_down_interval   = optional(number)
      interface_monitor = optional(list(object({
        name   = optional(string)
        weight = optional(number)
      })))
      preempt        = optional(bool)
      preempt_delay  = optional(number)
      preempt_limit  = optional(number)
      preempt_period = optional(number)
    }))
    reth_count                           = number
    config_sync_no_secondary_bootup_auto = optional(bool)
    control_ports = optional(object({
      fpc  = number
      port = number
    }))
    control_link_recovery = optional(bool)
    heartbeat_interval    = optional(number)
    heartbeat_threshold   = optional(number)
  })
  default = null
}


##################################################################################
resource "junos_chassis_cluster" "this" {
  count = var.chassis_cluster != null ? 1 : 0

  dynamic "fab0" {
    for_each = [var.chassis_cluster.fab0]
    content {
      member_interfaces = fab0.value.member_interfaces
      description       = fab0.value.description
    }
  }
  dynamic "fab1" {
    for_each = var.chassis_cluster.fab1 != null ? [var.chassis_cluster.fab1] : []
    content {
      member_interfaces = fab1.value.member_interfaces
      description       = fab1.value.description
    }
  }

  dynamic "redundancy_group" {
    for_each = var.chassis_cluster.redundancy_group
    iterator = redundancy
    content {
      node0_priority       = redundancy.value.node0_priority
      node1_priority       = redundancy.value.node1_priority
      gratuitous_arp_count = redundancy.value.gratuitous_arp_count
      hold_down_interval   = redundancy.value.hold_down_interval
      dynamic "interface_monitor" {
        for_each = redundancy.value.interface_monitor != null ? redundancy.value.interface_monitor : []
        iterator = monit
        content {
          name   = monit.value.name
          weight = monit.value.weight
        }
      }
      preempt        = redundancy.value.preempt
      preempt_delay  = redundancy.value.preempt_delay
      preempt_limit  = redundancy.value.preempt_limit
      preempt_period = redundancy.value.preempt_period
    }
  }

  reth_count                           = var.chassis_cluster.reth_count
  config_sync_no_secondary_bootup_auto = var.chassis_cluster.config_sync_no_secondary_bootup_auto

  dynamic "control_ports" {
    for_each = var.chassis_cluster.control_ports != null ? [var.chassis_cluster.control_ports] : []
    iterator = control
    content {
      fpc  = control.value.fpc
      port = control.value.port
    }
  }

  control_link_recovery = var.chassis_cluster.control_link_recovery
  heartbeat_interval    = var.chassis_cluster.heartbeat_interval
  heartbeat_threshold   = var.chassis_cluster.heartbeat_threshold
}
