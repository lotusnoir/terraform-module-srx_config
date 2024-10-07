#################################################################################################
variable "routing_instance" {
  type = map(object({
    configure_rd_vrfopts_singly = optional(bool)
    configure_type_singly       = optional(bool)
    type                        = optional(string)
    as                          = optional(string)
    description                 = optional(string)
    instance_export             = optional(set(string))
    instance_import             = optional(set(string))
    route_distinguisher         = optional(string)
    router_id                   = optional(string)
    vrf_export                  = optional(set(string))
    vrf_import                  = optional(set(string))
    vrf_target                  = optional(string)
    vrf_target_auto             = optional(bool)
    vrf_target_export           = optional(string)
    vrf_target_import           = optional(string)
    vtep_source_interface       = optional(string)
  }))
  default = {}
}


#################################################################################################
### OK
resource "junos_routing_instance" "this" {
  for_each = var.routing_instance != null ? var.routing_instance : null

  name                        = each.key
  configure_rd_vrfopts_singly = each.value.configure_rd_vrfopts_singly
  configure_type_singly       = each.value.configure_type_singly
  type                        = each.value.type
  as                          = each.value.as
  description                 = each.value.description
  instance_export             = each.value.instance_export
  instance_import             = each.value.instance_import
  route_distinguisher         = each.value.route_distinguisher
  router_id                   = each.value.router_id
  vrf_export                  = each.value.vrf_export
  vrf_import                  = each.value.vrf_import
  vrf_target                  = each.value.vrf_target
  vrf_target_auto             = each.value.vrf_target_auto
  vrf_target_export           = each.value.vrf_target_export
  vrf_target_import           = each.value.vrf_target_import
  vtep_source_interface       = each.value.vtep_source_interface
}
