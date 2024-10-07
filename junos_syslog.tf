###########################################################################################################
variable "syslog_host" {
  type = map(object({
    #host                         = string
    allow_duplicates             = optional(bool)
    exclude_hostname             = optional(bool)
    explicit_priority            = optional(bool)
    facility_override            = optional(string)
    log_prefix                   = optional(string)
    match                        = optional(string)
    match_strings                = optional(list(string))
    port                         = optional(number)
    source_address               = optional(string)
    structured_data              = optional(bool)
    structured_data_brief        = optional(bool)
    any_severity                 = optional(string)
    authorization_severity       = optional(string)
    changelog_severity           = optional(string)
    conflictlog_severity         = optional(string)
    daemon_severity              = optional(string)
    dfc_severity                 = optional(string)
    external_severity            = optional(string)
    firewall_severity            = optional(string)
    ftp_severity                 = optional(string)
    interactivecommands_severity = optional(string)
    kernel_severity              = optional(string)
    ntp_severity                 = optional(string)
    pfe_severity                 = optional(string)
    security_severity            = optional(string)
    user_severity                = optional(string)
  }))
  default = {}
}

resource "junos_system_syslog_host" "this" {
  # for_each = var.syslog_host != null ? { for k, v in var.syslog_host : v.host => v } : {}
  for_each = var.syslog_host != null ? var.syslog_host : null

  host              = each.key
  allow_duplicates  = each.value.allow_duplicates
  exclude_hostname  = each.value.exclude_hostname
  explicit_priority = each.value.explicit_priority
  facility_override = each.value.facility_override
  log_prefix        = each.value.log_prefix
  match             = each.value.match
  match_strings     = each.value.match_strings
  port              = each.value.port
  source_address    = each.value.source_address
  dynamic "structured_data" {
    for_each = each.value.structured_data != null ? [1] : []
    content {
      brief = each.value.structured_data_brief
    }
  }
  any_severity                 = each.value.any_severity
  authorization_severity       = each.value.authorization_severity
  changelog_severity           = each.value.changelog_severity
  conflictlog_severity         = each.value.conflictlog_severity
  daemon_severity              = each.value.daemon_severity
  dfc_severity                 = each.value.dfc_severity
  external_severity            = each.value.external_severity
  firewall_severity            = each.value.firewall_severity
  ftp_severity                 = each.value.ftp_severity
  interactivecommands_severity = each.value.interactivecommands_severity
  kernel_severity              = each.value.kernel_severity
  ntp_severity                 = each.value.ntp_severity
  pfe_severity                 = each.value.pfe_severity
  security_severity            = each.value.security_severity
  user_severity                = each.value.user_severity
}

##################################################################################
variable "syslog_file" {
  type = list(object({
    filename              = string
    allow_duplicates      = optional(bool)
    explicit_priority     = optional(bool)
    match                 = optional(string)
    match_strings         = optional(list(string))
    structured_data       = optional(bool)
    structured_data_brief = optional(bool)
    #structured_data = optional(object({
    #  brief = optional(bool)
    #}))
    archive = optional(object({
      binary_data    = optional(bool)
      no_binary_data = optional(bool)
      files          = optional(number)
      sites = optional(object({
        url              = optional(string)
        password         = optional(string)
        routing_instance = optional(string)
      }))
      size              = optional(number)
      start_time        = optional(string)
      transfer_interval = optional(number)
      world_readable    = optional(bool)
      no_world_readable = optional(bool)
    }))
    any_severity                 = optional(string)
    authorization_severity       = optional(string)
    changelog_severity           = optional(string)
    conflictlog_severity         = optional(string)
    daemon_severity              = optional(string)
    dfc_severity                 = optional(string)
    external_severity            = optional(string)
    firewall_severity            = optional(string)
    ftp_severity                 = optional(string)
    interactivecommands_severity = optional(string)
    kernel_severity              = optional(string)
    ntp_severity                 = optional(string)
    pfe_severity                 = optional(string)
    security_severity            = optional(string)
    user_severity                = optional(string)
  }))
  default = []
}

resource "junos_system_syslog_file" "this" {
  for_each = var.syslog_file != null ? { for k, v in var.syslog_file : v.filename => v } : {}

  filename          = each.value.filename
  allow_duplicates  = each.value.allow_duplicates
  explicit_priority = each.value.explicit_priority
  match             = each.value.match
  match_strings     = each.value.match_strings
  dynamic "structured_data" {
    for_each = each.value.structured_data != null ? [1] : []
    content {
      brief = each.value.structured_data_brief
    }
  }
  dynamic "archive" {
    for_each = each.value.archive != null ? [each.value.archive] : []
    iterator = archive
    content {
      binary_data    = archive.value.binary_data
      no_binary_data = archive.value.no_binary_data
      files          = archive.value.files
      dynamic "sites" {
        for_each = archive.value.sites != null ? [archive.value.sites] : []
        iterator = sites
        content {
          url              = sites.value.url
          password         = sites.value.password
          routing_instance = sites.value.routing_instance
        }
      }
      size              = archive.value.size
      start_time        = archive.value.start_time
      transfer_interval = archive.value.transfer_interval
      world_readable    = archive.value.world_readable
      no_world_readable = archive.value.no_world_readable
    }
  }
  any_severity                 = each.value.any_severity
  authorization_severity       = each.value.authorization_severity
  changelog_severity           = each.value.changelog_severity
  conflictlog_severity         = each.value.conflictlog_severity
  daemon_severity              = each.value.daemon_severity
  dfc_severity                 = each.value.dfc_severity
  external_severity            = each.value.external_severity
  firewall_severity            = each.value.firewall_severity
  ftp_severity                 = each.value.ftp_severity
  interactivecommands_severity = each.value.interactivecommands_severity
  kernel_severity              = each.value.kernel_severity
  ntp_severity                 = each.value.ntp_severity
  pfe_severity                 = each.value.pfe_severity
  security_severity            = each.value.security_severity
  user_severity                = each.value.user_severity
}


##################################################################################
variable "syslog_user" {
  type = list(object({
    username                     = string
    allow_duplicates             = optional(bool)
    match                        = optional(string)
    match_strings                = optional(list(string))
    any_severity                 = optional(string)
    authorization_severity       = optional(string)
    changelog_severity           = optional(string)
    conflictlog_severity         = optional(string)
    daemon_severity              = optional(string)
    dfc_severity                 = optional(string)
    external_severity            = optional(string)
    firewall_severity            = optional(string)
    ftp_severity                 = optional(string)
    interactivecommands_severity = optional(string)
    kernel_severity              = optional(string)
    ntp_severity                 = optional(string)
    pfe_severity                 = optional(string)
    security_severity            = optional(string)
    user_severity                = optional(string)
  }))
  default = []
}

resource "junos_system_syslog_user" "this" {
  for_each = var.syslog_user != null ? { for k, v in var.syslog_user : v.username => v } : {}

  username                     = each.value.username
  allow_duplicates             = each.value.allow_duplicates
  match                        = each.value.match
  match_strings                = each.value.match_strings
  any_severity                 = each.value.any_severity
  authorization_severity       = each.value.authorization_severity
  changelog_severity           = each.value.changelog_severity
  conflictlog_severity         = each.value.conflictlog_severity
  daemon_severity              = each.value.daemon_severity
  dfc_severity                 = each.value.dfc_severity
  external_severity            = each.value.external_severity
  firewall_severity            = each.value.firewall_severity
  ftp_severity                 = each.value.ftp_severity
  interactivecommands_severity = each.value.interactivecommands_severity
  kernel_severity              = each.value.kernel_severity
  ntp_severity                 = each.value.ntp_severity
  pfe_severity                 = each.value.pfe_severity
  security_severity            = each.value.security_severity
  user_severity                = each.value.user_severity
}
