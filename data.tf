#data "junos_interfaces_physical_present" "interfaces_ge" {
#  match_name = "^ge-.*$"
#}
#
#output "data1" { value = data.junos_interfaces_physical_present.interfaces_ge }
#
#
#data "junos_interface_logical" "interface_fw_demo" {
#  config_interface = "ge-0/0/1.2003"
#}
#
#
#output "data2" { value = data.junos_interface_logical.interface_fw_demo }
