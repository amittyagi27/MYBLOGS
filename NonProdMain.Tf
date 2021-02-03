#####################################################################
#	File Name 	:- NonProdMain.Tf
#	Description :- This is Terraform Resource File
#	Developed by :- Amit Tyagi
#	Last Updated :- 11-Sep-2020
####################################################################


locals {
    Project_vcn_id      = oci_core_vcn.vcn.id
}

locals {
    Project_vcn_name      = oci_core_vcn.vcn.display_name
}

locals {
    Private_Subnet_Dns      = oci_core_subnet.subnet_dev_private.subnet_domain_name
}


############### PROVIDER 

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}


############################### VCN


 resource "oci_core_vcn" "vcn" {
  compartment_id = var.compartment_network_ocid
  display_name   = join("_",[var.Resource_prefix,var.Resource_suffix_dev,"Vcn"])
  dns_label      = var.vcn_dns_prefix
  cidr_block     = var.vcn_cidr
}	
  
 
############################## Gateways


## Internet Gateway

resource "oci_core_internet_gateway" "internet_gateway" {
    #Required
    compartment_id = var.compartment_network_ocid
    vcn_id = local.Project_vcn_id
    #Optional
    display_name = join("_",[local.Project_vcn_name,"InternetGateway"])
    
}

## Nat Gateway

resource "oci_core_nat_gateway" "nat_gateway" {
    #Required
    compartment_id = var.compartment_network_ocid	
    vcn_id = local.Project_vcn_id

    #Optional
    display_name = join("_",[local.Project_vcn_name,"NatGateway"])
  
}

## Service Gateway

data "oci_core_services" "dev_services" {
}

resource "oci_core_service_gateway" "service_gateway" {
    #Required
    compartment_id = var.compartment_network_ocid	
    services {
        #Required
   	   service_id =  data.oci_core_services.dev_services.services.1.id
    }
    vcn_id = local.Project_vcn_id

    #Optional
    
    display_name = join("_",[local.Project_vcn_name,"ServiceGateway"])
}

################################ SUBNETS

###PUBLIC SUBNET

## Route Table		
resource "oci_core_route_table" "route_table_dev_public" {	
	compartment_id = var.compartment_network_ocid
	 vcn_id = local.Project_vcn_id
	 display_name = join("_",[ var.Resource_suffix_dev,"Public_Subnet_RT"])
 route_rules {
         #Required
         network_entity_id = oci_core_internet_gateway.internet_gateway.id
         #Optional
         cidr_block = "0.0.0.0/0"
         description = "Routing Rule for Internet access"
         
     }
 }

 ## Security List
 resource "oci_core_security_list" "security_list_dev_public" {
     compartment_id = var.compartment_network_ocid
     vcn_id = local.Project_vcn_id
     display_name = join("_",[ var.Resource_suffix_dev,"Public_Subnet_SL"])
	 
	 egress_security_rules {
	         #Required
	         destination = "0.0.0.0/0"
	         protocol = "ALL"
			 destination_type="CIDR_BLOCK"
	}		
	ingress_security_rules {
	        #Required
	        protocol = "6"
	        source = "0.0.0.0/0"
	source_type = "CIDR_BLOCK"
    tcp_options {
               #Optional
               max = "22"
               min = "22"
             #  source_port_range {
                   #Required
        #           max = ""
         #          min = "0"
     	#	 }	  
	  }	
	}	
	ingress_security_rules {
	        #Required
	        protocol = "1"
	        source = "0.0.0.0/0"
    icmp_options {
               #Required
               type = "3"
               #Optional
               code = "4"
           }
	source_type = "CIDR_BLOCK"	
	}
	ingress_security_rules {
	        #Required
	        protocol = "1"
	        source = "0.0.0.0/0"
    icmp_options {
               #Required
               type = "3"
               #Optional
               code = "0"
           }
	source_type = "CIDR_BLOCK"	
	}
 }
 
	 
 ## Subnet	 
 resource "oci_core_subnet" "subnet_dev_public" {
   compartment_id      = var.compartment_network_ocid
   vcn_id              = local.Project_vcn_id
   display_name        = join("_",[ var.Resource_suffix_dev,"Public_Subnet"])
   cidr_block          = var.subnet_dev_pub_cidr
   route_table_id      = oci_core_route_table.route_table_dev_public.id
   security_list_ids   =  ["${oci_core_security_list.security_list_dev_public.id}"]
   dns_label = join("",[ var.Resource_suffix_dev,"PubSubnet"])
 } 
 

 #### Private SUBNET
 
## Route Table

resource "oci_core_route_table" "route_table_dev_private" {	
	compartment_id = var.compartment_network_ocid
	 vcn_id = local.Project_vcn_id
	 display_name = join("_",[ var.Resource_suffix_dev,"Private_Subnet_RT"])
	 route_rules {
	         #Required
	         network_entity_id = oci_core_nat_gateway.nat_gateway.id
	         #Optional
	         cidr_block = "0.0.0.0/0"
	         description = "Routing Rule for Nat Gateway"
         
	     }
		 route_rules {
		         #Required
		         network_entity_id = oci_core_service_gateway.service_gateway.id
		         #Optional
				# cidr_block = data.oci_core_services.dev_services.services.1.id
				 destination_type="SERVICE_CIDR_BLOCK"
				 destination=data.oci_core_services.dev_services.services.1.cidr_block
		         description = "Routing Rule for service Gateway"
		     }
 }
 
 ## Security List
 resource "oci_core_security_list" "security_list_dev_private" {
     compartment_id = var.compartment_network_ocid
     vcn_id = local.Project_vcn_id
     display_name = join("_",[ var.Resource_suffix_dev,"Private_Subnet_SL"])
	 
	 egress_security_rules {
	         #Required
	         destination = "0.0.0.0/0"
	         protocol = "ALL"
			 destination_type="CIDR_BLOCK"
	}		
	ingress_security_rules {
	        #Required
	        protocol = "6"
	        source = "0.0.0.0/0"
	source_type = "CIDR_BLOCK"
    tcp_options {
               #Optional
               max = "22"
               min = "22"
             #  source_port_range {
                   #Required
        #           max = ""
         #          min = "0"
     	#	 }	  
	  }	
	}	
	ingress_security_rules {
	        #Required
	        protocol = "6"
	        source = var.vcn_cidr
	source_type = "CIDR_BLOCK"
    tcp_options {
               #Optional
               max = "1521"
               min = "1521"
             #  source_port_range {
                   #Required
        #           max = ""
         #          min = "0"
     	#	 }	  
	  }	
	}	
	ingress_security_rules {
	        #Required
	        protocol = "6"
	        source = var.vcn_cidr
	source_type = "CIDR_BLOCK"
    tcp_options {
               #Optional
               max = "8080"
               min = "8080"
             #  source_port_range {
                   #Required
        #           max = ""
         #          min = "0"
     	#	 }	  
	  }	
	}	
	ingress_security_rules {
	        #Required
	        protocol = "1"
	        source = "0.0.0.0/0"
    icmp_options {
               #Required
               type = "3"
               #Optional
               code = "4"
           }
	source_type = "CIDR_BLOCK"	
	}
	ingress_security_rules {
	        #Required
	        protocol = "1"
	        source = "0.0.0.0/0"
    icmp_options {
               #Required
               type = "3"
               #Optional
               code = "0"
           }
	source_type = "CIDR_BLOCK"	
	}
 }

 ## Subnet	
 resource "oci_core_subnet" "subnet_dev_private" {
   compartment_id      = var.compartment_network_ocid
   vcn_id              = local.Project_vcn_id
   display_name        = join("_",[ var.Resource_suffix_dev,"Private_Subnet"])
   cidr_block          = var.subnet_dev_pvt_cidr
   route_table_id      = oci_core_route_table.route_table_dev_private.id
   security_list_ids   =  ["${oci_core_security_list.security_list_dev_private.id}"]
   dns_label 		   =  join("",[ var.Resource_suffix_dev,"PvtSubnet"])
 } 	
 

 ##Database 
 
 resource "oci_database_db_system" "dev_db_system" {
     #Required
     availability_domain = var.availability_domain
     compartment_id = var.compartment_nonprod_ocid
     db_home {
         #Required
         database {
             #Required
             admin_password = var.database_admin_password
             db_name = "DEVDB"  
             db_workload = var.database_db_workload
             pdb_name = var.database_pdb_name	
            
         }

         #Optional
         db_version = var.database_version
         display_name = join("_",[var.Resource_suffix_dev, var.Resource_main,"DB"])  #Dev_Analytics_DB
     }
     hostname = join("",[var.Resource_suffix_dev, var.Resource_main,"DB"])  #Dev_Analytics_DB 
	 shape = var.database_shape
     ssh_public_keys = [var.database_ssh_pub_key]
     subnet_id = oci_core_subnet.subnet_dev_private.id	
	 data_storage_size_in_gb = var.database_storage
	 database_edition = var.database_edition
	 display_name=join("_",[var.Resource_suffix_dev, var.Resource_main,"DB"])	
	 domain = local.Private_Subnet_Dns			# domain should be same as subnet
	 node_count = var.database_nodecount
 } 

 ## OAC
 
 resource "oci_analytics_analytics_instance" "Nonprod_analytics_instance" {
     #Required
     capacity {
         #Required
         capacity_type = var.oac_capacity_type
         capacity_value = var.oac_capacity_value
     }
     compartment_id = var.compartment_nonprod_ocid
     feature_set = var.oac_feature_set
     license_type = var.oac_license_type		
     name = join("_",[var.Resource_suffix_dev, "OAC"])

     #Optional
     description = join(" ",[var.Resource_prefix, "Development", var.Resource_main,])
     idcs_access_token = var.oac_idcs_token
    # network_endpoint_details {
         #Required
        # network_endpoint_type = "${var.analytics_instance_network_endpoint_details_network_endpoint_type}"
         #Optional
       #  subnet_id = "${oci_core_subnet.test_subnet.id}"
       #  vcn_id = "${oci_core_vcn.test_vcn.id}"
       #  whitelisted_ips = "${var.analytics_instance_network_endpoint_details_whitelisted_ips}"
       #  whitelisted_vcns {

             #Optional
        #     id = "${var.analytics_instance_network_endpoint_details_whitelisted_vcns_id}"
       #      whitelisted_ips = "${var.analytics_instance_network_endpoint_details_whitelisted_vcns_whitelisted_ips}"
      #   }
    # }
 }
 

 ## RDG
 
 resource "oci_core_instance" "Nonprod_rdg" {
   compartment_id = var.compartment_nonprod_ocid
   display_name = join("_",[ var.Resource_suffix_dev,"RDG"]) 
   availability_domain = var.availability_domain

   source_details {
     source_id = var.rdg_custom_image
     source_type = "image"
   }
   shape = var.rdg_compute_shape
   create_vnic_details {
     subnet_id = oci_core_subnet.subnet_dev_private.id
     display_name = "primary-vnic"
     assign_public_ip = true
     #private_ip = "192.168.10.2"
     hostname_label = "devrdg"
   }
   metadata= {
     ssh_authorized_keys = var.rdg_ssh_pub_key
   }
 }


 ## Bastion
 
 resource "oci_core_instance" "Dev_Bastion" {
   compartment_id = var.compartment_nonprod_ocid
   display_name = join("_",[ var.Resource_suffix_dev,"Bastion"]) 
   availability_domain = var.availability_domain
   source_details {
     source_id = var.bastion_image_id
     source_type = "image"
   }
   shape = var.rdg_compute_shape
   create_vnic_details {
     subnet_id = oci_core_subnet.subnet_dev_public.id
     display_name = "primary-vnic"
     assign_public_ip = true
     #private_ip = "192.168.10.2"
     hostname_label = "devbastion"
   }
   metadata= {
     ssh_authorized_keys = var.rdg_ssh_pub_key
   }
 }


 
