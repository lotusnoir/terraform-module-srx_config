# terraform-module-srx_config

This module was made to configure our srx firewall server. It doesnt contains all possible configuration and it can be improve. We tried to make shortcuts to make it simplier to use and to read.
we will configure the following:


## System

    terraform import junos_system.system random
    terraform import junos_system_ntp_server.ntp_server1 10.1.80.47
    terraform import junos_system_ntp_server.ntp_server2 10.1.80.48
    terraform import junos_system_syslog_host.syslog_host 10.1.80.54
    terraform import junos_system_root_authentication.root_auth random

To add new system values


### snmp.tf

    terraform import junos_snmp.snmp random
    terraform import junos_snmp_community.cpdea cpdea

To add new snmp

    snmp = {
      contact = "noc@axione.fr"
      location = "OVH - roubaix, France"
      health_monitor = [{
        falling_threshold = 22
        interval = 45
      }]
    }
  
    snmp_community = {
      cpdea = {
        authorization_read_only = true
        routing_instance = {
          toto = {
            client_list_name = "titi"
            clients = ["10.4.1.0/24", "10.4.4.0/24"]
          }
        }
      }
    }


## Security zones

security zones must exist before creating interfaces

In case the firewall isnt empty we can import the existing configuration like this:

    terraform import module.xxxxxxx.junos_security_zone.this[\"ZONENAME\"] ZONENAME
    terraform import junos_security_zone.common_staging common-staging


to add new zone use the variable security_zones

    security_zones = {
      interco_pfs = {
        inbound_protocols = ["bgp"]
        inbound_services  = ["ping"]
      }
      common-staging = {
        inbound_services  = ["ping"]
      }
      secure-staging = {}
    }



## interfaces

We consider physical and logical interfaces

To import existing config:

    terraform import module.fwv-rbx59-08-test.junos_interface_physical.this[\"ge-0/0/1\"] ge-0/0/1
    terraform import module.fwv-rbx59-08-test.junos_interface_logical.this[\"ge-0/0/1.2099\"] ge-0/0/1.2099

To add interfaces we do:

  interfaces_logical = {
    "ge-0/0/0.1907" = {
      routing_instance          = "PFSv2"
      security_zone             = "interco_pfs"
      security_inbound_services = ["ping"]
      cidr_ip = ["10.1.254.105/31"]
      }
    "ge-0/0/1.2021" = {
      routing_instance          = "PFSv2"
      security_zone             = "common-staging"
      security_inbound_services = ["ping"]
      cidr_ip = ["10.4.5.1/24"]
    }
  }

  
## policy-statements

    terraform import junos_policyoptions_policy_statement.export-907 export-907
    terraform import junos_policyoptions_policy_statement.import-907 import-907

To add new policy statements:

    policy_statements = {
      "export-907" = {
        zone3 = ["10.2.0.0/24", "10.2.1.0/24"]
      }
      import-907 = {
        zone1    = ["10.1.2.0/24", "10.1.3.0/24"]
        zone2    = ["10.4.1.0/22"]
      }
    }


## routing instance

  terraform import junos_routing_instance.PFSv2 PFSv2
  terraform import junos_bgp_group.PFSv2 VPRN907_-_PFSv2
  terraform import junos_bgp_neighbor.PFSv2 10.1.254.104_-_PFSv2_-_VPRN907

To add new routing instances:

    routing_instance = {
      PFSv2 = {
        type = "virtual-router"
        as = "65059"
      }
    }
  
    bgp_group = {
      VPRN907 = {
        routing_instance = "PFSv2"
        type  = "external"
        peer_as          = "31167"
        import = ["import-907"]
        export = ["export-907"]
      }
    }
 
    bgp_neighbor = {
      PFSv2 = {
        group = "VPRN907"
        ip               = "10.1.254.104"
      }
    }


## Add new vlan

Exemple: roubaix	pcc-92-222-223-4_datacenter1710	staging	2	common	2021	common-staging	10.4.5.0/24		fwv-rbx59-08.infra	PFSv2

1/ ensure subnet routes exist in policy options

      route_filter {
        route        = "10.4.5.0/24"
        option       = "exact"
        option_value = "accept"
      }

1/ create a security zone

    resource "junos_security_zone" "common_staging" {
      name             = "common-staging"
      inbound_services = ["ping"]
    }

2/ create an interface

    resource "junos_interface_logical" "common_staging" {
      depends_on = [junos_security_zone.common_staging]
    
      name                      = "ge-0/0/1.2021"
      description               = "common-staging"
      vlan_id                   = "2021"
      routing_instance          = "PFSv2"
      security_zone             = "common-staging"
      security_inbound_services = ["ping"]
      family_inet {
        address {
          cidr_ip = "10.4.5.1/24"
        }
      }
    }

## Add a configuration not supported by provider

    commit_config = [
      "set routing-options static route 0.0.0.0/0 next-hop 10.1.52.1"
    ]
