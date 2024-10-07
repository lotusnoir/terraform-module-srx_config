## health_monitor shouldnt be a list of objects, need to be fix
##################################################################################
variable "snmp" {
  type = object({
    clean_on_destroy                = optional(bool)
    arp                             = optional(bool)
    arp_host_name_resolution        = optional(bool)
    contact                         = optional(string)
    description                     = optional(string)
    engine_id                       = optional(string)
    filter_duplicates               = optional(bool)
    filter_interfaces               = optional(set(string))
    filter_internal_interfaces      = optional(bool)
    if_count_with_filter_interfaces = optional(bool)
    interface                       = optional(set(string))
    location                        = optional(string)
    routing_instance_access         = optional(bool)
    routing_instance_access_list    = optional(set(string))
    health_monitor = optional(list(object({
      falling_threshold     = optional(number)
      idp                   = optional(bool)
      idp_falling_threshold = optional(number)
      idp_interval          = optional(number)
      idp_rising_threshold  = optional(number)
      interval              = optional(number)
      rising_threshold      = optional(number)
    })))
    #community               = optional(string)
  })
  default = null
}

resource "junos_snmp" "this" {
  count = var.snmp != null ? 1 : 0

  clean_on_destroy                = var.snmp.clean_on_destroy
  arp                             = var.snmp.arp
  arp_host_name_resolution        = var.snmp.arp_host_name_resolution
  contact                         = var.snmp.contact
  description                     = var.snmp.description
  engine_id                       = var.snmp.engine_id
  filter_duplicates               = var.snmp.filter_duplicates
  filter_interfaces               = var.snmp.filter_interfaces
  filter_internal_interfaces      = var.snmp.filter_internal_interfaces
  if_count_with_filter_interfaces = var.snmp.if_count_with_filter_interfaces
  interface                       = var.snmp.interface
  location                        = var.snmp.location
  routing_instance_access         = var.snmp.routing_instance_access
  routing_instance_access_list    = var.snmp.routing_instance_access_list
  dynamic "health_monitor" {
    for_each = var.snmp.health_monitor != null ? var.snmp.health_monitor : []
    content {
      falling_threshold     = health_monitor.value.falling_threshold != null ? health_monitor.value.falling_threshold : null
      idp                   = health_monitor.value.idp != null ? health_monitor.value.idp : null
      idp_falling_threshold = health_monitor.value.idp_falling_threshold != null ? health_monitor.value.idp_falling_threshold : null
      idp_interval          = health_monitor.value.idp_interval != null ? health_monitor.value.idp_interval : null
      idp_rising_threshold  = health_monitor.value.idp_rising_threshold != null ? health_monitor.value.idp_rising_threshold : null
      interval              = health_monitor.value.interval != null ? health_monitor.value.interval : null
      rising_threshold      = health_monitor.value.rising_threshold != null ? health_monitor.value.rising_threshold : null
    }
  }
}


##################################################################################
variable "snmp_community" {
  type = map(object({
    authorization_read_only  = optional(bool)
    authorization_read_write = optional(bool)
    client_list_name         = optional(string)
    clients                  = optional(set(string))
    view                     = optional(string)
    routing_instance = optional(map(object({
      client_list_name = optional(string)
      clients          = optional(set(string))
    })))
  }))
  default = {}
}

resource "junos_snmp_community" "this" {
  for_each                 = var.snmp_community != null ? var.snmp_community : {}
  name                     = each.key
  authorization_read_only  = each.value.authorization_read_only
  authorization_read_write = each.value.authorization_read_write
  client_list_name         = each.value.client_list_name
  clients                  = each.value.clients
  view                     = each.value.view

  dynamic "routing_instance" {
    for_each = each.value.routing_instance != null ? each.value.routing_instance : {}

    content {
      name             = routing_instance.key
      client_list_name = routing_instance.value.client_list_name
      clients          = routing_instance.value.clients
    }
  }
}
