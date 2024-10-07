##################################################################################  
variable "login_user" {
  type = map(object({
    class = optional(string)
    uid   = optional(string)
    authentication = optional(object({
      encrypted_password  = optional(string)
      no_public_keys      = optional(set(string))
      plain_text_password = optional(string)
      ssh_public_keys     = optional(set(string))
    }))
    cli_prompt = optional(string)
    full_name  = optional(string)
  }))
  default = {}
}

resource "junos_system_login_user" "this" {
  for_each = var.login_user != null ? var.login_user : {}

  name  = each.key
  class = each.value.class
  uid   = each.value.uid
  dynamic "authentication" {
    for_each = each.value.authentication != null ? [each.value.authentication] : []

    content {
      encrypted_password  = authentication.value.encrypted_password
      no_public_keys      = authentication.value.no_public_keys
      plain_text_password = authentication.value.plain_text_password
      ssh_public_keys     = authentication.value.ssh_public_keys
    }
  }
  cli_prompt = each.value.cli_prompt
  full_name  = each.value.full_name
}
