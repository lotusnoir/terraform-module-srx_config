output "system" { value = var.system }
output "chassis_cluster" { value = var.chassis_cluster }
output "syslog_host" { value = var.syslog_host }
output "static_route" { value = var.static_route }
output "flattened_static_route" { value = local.flattened_static_route }
