##################################################################################                                                                                                                                             
variable "commit_config" {
  type    = set(string)
  default = null
}

resource "junos_null_commit_file" "commit" {
  count = var.commit_config != null ? 1 : 0

  filename     = "null_commit"
  append_lines = var.commit_config
  #clear_file_after_commit = true
}
