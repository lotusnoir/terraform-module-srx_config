################################################################################################
variable "security_log_stream" {
  type = map(object({
    category = optional(list(string))
    file = optional(object({
      name             = optional(string)
      allow_duplicates = optional(bool)
      rotation         = optional(number)
      size             = optional(number)
    }))
    filter_threat_attack = optional(bool)
    format               = optional(string)
    host = optional(object({
      ip_address       = optional(string)
      port             = optional(number)
      routing_instance = optional(string)
    }))
    rate_limit = optional(number)
    severity   = optional(string)
    transport = optional(object({
      protocol        = optional(string)
      tcp_connections = optional(number)
      tls_profile     = optional(string)
    }))
  }))
  default = {}
}


################################################################################################
resource "junos_security_log_stream" "this" {
  for_each = var.security_log_stream != null ? var.security_log_stream : null

  name     = each.key
  category = each.value.category
  dynamic "file" {
    for_each = each.value.file != null ? [each.value.file] : []
    content {
      name             = file.value.name
      allow_duplicates = file.value.allow_duplicates
      rotation         = file.value.rotation
      size             = file.value.size
    }
  }
  filter_threat_attack = each.value.filter_threat_attack
  format               = each.value.format
  dynamic "host" {
    for_each = each.value.host != null ? [each.value.host] : []
    content {
      ip_address       = host.value.ip_address
      port             = host.value.port
      routing_instance = host.value.routing_instance
    }
  }
  rate_limit = each.value.rate_limit
  severity   = each.value.severity
  dynamic "transport" {
    for_each = each.value.transport != null ? [each.value.transport] : []
    content {
      protocol        = transport.value.protocol
      tcp_connections = transport.value.tcp_connections
      tls_profile     = transport.value.tls_profile
    }
  }

}
