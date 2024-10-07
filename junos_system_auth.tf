##################################################################################
variable "root_auth" {
  type = object({
    encrypted_password  = optional(string)
    plain_text_password = optional(string)
    no_public_keys      = optional(bool)
    ssh_public_keys     = optional(set(string))
  })
  default = null
}

resource "junos_system_root_authentication" "this" {
  count = var.root_auth != null ? 1 : 0

  encrypted_password  = var.root_auth.encrypted_password
  plain_text_password = var.root_auth.plain_text_password
  no_public_keys      = var.root_auth.no_public_keys
  ssh_public_keys     = var.root_auth.ssh_public_keys
}


##################################################################################
variable "radius_servers" {
  type = map(object({
    secret                   = optional(string)
    accounting_port          = optional(number)
    accounting_retry         = optional(number)
    accounting_timeout       = optional(number)
    dynamic_request_port     = optional(number)
    max_outstanding_requests = optional(number)
    port                     = optional(number)
    preauthentication_port   = optional(number)
    preauthentication_secret = optional(string)
    retry                    = optional(number)
    routing_instance         = optional(string)
    source_address           = optional(string)
    timeout                  = optional(number)
  }))
  default = {}
}

resource "junos_system_radius_server" "this" {
  for_each = var.radius_servers != null ? var.radius_servers : {}

  address                  = each.key
  secret                   = each.value.secret
  accounting_port          = each.value.accounting_port
  accounting_retry         = each.value.accounting_retry
  accounting_timeout       = each.value.accounting_timeout
  dynamic_request_port     = each.value.dynamic_request_port
  max_outstanding_requests = each.value.max_outstanding_requests
  port                     = each.value.port
  preauthentication_port   = each.value.preauthentication_port
  preauthentication_secret = each.value.preauthentication_secret
  retry                    = each.value.retry
  routing_instance         = each.value.routing_instance
  source_address           = each.value.source_address
  timeout                  = each.value.timeout
}


##################################################################################
variable "tacplus_servers" {
  type = map(object({
    port              = optional(number)
    routing_instance  = optional(string)
    secret            = optional(string)
    single_connection = optional(bool)
    source_address    = optional(string)
    timeout           = optional(number)
  }))
  default = {}
}

resource "junos_system_tacplus_server" "this" {
  for_each = var.tacplus_servers != null ? var.tacplus_servers : {}

  address           = each.key
  port              = each.value.port
  routing_instance  = each.value.routing_instance
  secret            = each.value.secret
  single_connection = each.value.single_connection
  source_address    = each.value.source_address
  timeout           = each.value.timeout
}
