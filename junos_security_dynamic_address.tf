################################################################################################
variable "security_dynamic_address_feed_server" {
  type = map(object({
    hostname    = optional(string)
    url         = optional(string)
    description = optional(string)
    feed_name = optional(map(object({
      name            = optional(string)
      path            = optional(string)
      description     = optional(string)
      hold_interval   = optional(number)
      update_interval = optional(number)
    })))
    hold_interval                                  = optional(number)
    tls_profile                                    = optional(string)
    update_interval                                = optional(number)
    validate_certificate_attributes_subject_or_san = optional(bool)
  }))
  default = {}
}

variable "security_dynamic_address_name" {
  type = map(object({
    description       = optional(string)
    profile_feed_name = optional(string)
    profile_category = optional(object({
      name = optional(string)
      feed = optional(string)
      property = optional(object({
        name   = optional(string)
        string = optional(list(string))
      }))
    }))
  }))
  default = {}
}



################################################################################################
resource "junos_security_dynamic_address_feed_server" "this" {
  for_each = var.security_dynamic_address_feed_server != null ? var.security_dynamic_address_feed_server : null

  name        = each.key
  hostname    = each.value.hostname
  url         = each.value.url
  description = each.value.description
  dynamic "feed_name" {
    for_each = each.value.feed_name != null ? each.value.feed_name : {}
    content {
      name            = feed_name.key
      path            = feed_name.value.path
      description     = feed_name.value.description
      hold_interval   = feed_name.value.hold_interval
      update_interval = feed_name.value.update_interval
    }
  }
  hold_interval                                  = each.value.hold_interval
  tls_profile                                    = each.value.tls_profile
  update_interval                                = each.value.update_interval
  validate_certificate_attributes_subject_or_san = each.value.validate_certificate_attributes_subject_or_san
}

resource "junos_security_dynamic_address_name" "this" {
  for_each = var.security_dynamic_address_name != null ? var.security_dynamic_address_name : null

  name              = each.key
  description       = each.value.description
  profile_feed_name = each.value.profile_feed_name
  dynamic "profile_category" {
    for_each = each.value.profile_category != null ? [each.value.profile_category] : []
    content {
      name = profile_category.key
      feed = profile_category.value.feed
    }
  }
}
