#####################################################################
#	File Name 	:- Config.Tf
#	Description :- This file contains all OCI Configration Attributes
#	Developed by :- Amit Tyagi
#	Last Updated :- 11-Sep-2020
####################################################################

##General Variable

#### prefix - custome name without space #### Suffix - Environmnet type for e.g Dev, Test, Prod,PreProd, this will be used in all Resource Name.
Resource_prefix	= "Abc"  
Resource_suffix_dev	= "Dev"			# Suffix for Environment-1/Non Prod
Resource_suffix_prod = "Prod"		# Suffix for Environment-2/Prod
Resource_main	= "Analytics"

## Providers Variables
tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaawdbeeudthb3dedfkmxw5ong4nq66kyolra7w2bqq2txfa"
user_ocid        = "ocid1.user.oc1..aaaaaayw6cs4kccpxuvsog2kkqux4ukeezbhkpyv2bgjeqw6mnlxnhhhiclq"
fingerprint      = "ff:ef:93:c2:a0:6f:a8:7f:bc:e6:4b:bf:29:2a:9b"
private_key_path = "/Users/document/my_pvt_key.pem"
pass_phrase		 = ""	
region           = "us-ashburn-1"
availability_domain = "pSSn:US-ASHBURN-AD-1"


## Compartment Variables

compartment_nonprod_ocid = "ocid1.compartment.oc1..aaaaaaaaxuzzlz76bqhbwyfehifzhjiximb7kif7f3eyjyqis75xbfjza"
compartment_preprod_ocid = "ocid1.compartment.oc1..aaaaaaaagjgsyrvj3r2cj3dhwplrbkryds37oe4ivkareropjtl27y74q" ##Not Required so skip this
compartment_prod_ocid = "ocid1.compartment.oc1..aaaaaaaahf6q6rd7cem5pycicgddnwaxqdovtuctq2boenkqdmseduzpcq"
compartment_network_ocid ="ocid1.compartment.oc1..aaaaaaaal7wkibupw72kpuirangaa75w6drvqdkognwaviavdnzw3pi73q"

## VCN

vcn_cidr= "192.168.1.0/24"
vcn_dns_prefix="abcdev"

vcn_prod_cidr= "192.168.5.0/24"
vcn_prod_dns_prefix="abcprod"

### Subnet


subnet_dev_pub_cidr= "192.168.1.128/25"
subnet_dev_pvt_cidr= "192.168.1.0/25"

subnet_prod_pub_cidr= "192.168.5.0/25"
subnet_prod_pvt_cidr= "192.168.5.128/25"

## Database

database_admin_password= "MYdba_123#"
database_db_unique_name = ""
database_db_workload = "OLTP"
database_pdb_name= "PDB1"
database_version ="19.7.0.0"
database_shape= "VM.Standard2.1"
database_shape_prod= "VM.Standard2.2"
database_storage= "256"
database_storage_prod= "1024"
database_ssh_pub_key="ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAgz2c+ahjeJPTjnypdl/4EIUMe7M5qSQccOzj+hk3hDdNhvK5qUn6gwwTmD+bisDA5F7xST6HaUdHGIyM/oBcZSJfEeraGOHB7iixdNcPnvF9vlhFwnJ3HzoqCRRL1HNdbY8rqj4qeMWEO++ZmCCqrEwAxeZyycPHc3GZTxu/ekLwo2rRna3pHEa3paCrw2Bng+dRgYyV2Y2UzRGB6tyc2XE1vioUiEH5WwB/10BBlhVUHsgOXXgvAEbshCUbwf/MIuiOWnDLOkuM4B//EUA9/2Yva6xcnufZd3mwL3tgjifVn/1wzIxtJ5PG/J+TcjC55qwGO3qqDw== rsa-key-20200402"
database_edition="ENTERPRISE_EDITION"
database_nodecount = "1"

## OAC

oac_capacity_type = "OLPU_COUNT"
oac_capacity_value= 1
oac_capacity_value_prod= 2
oac_feature_set = "ENTERPRISE_ANALYTICS"
oac_license_type = "LICENSE_INCLUDED"
oac_idcs_token = "eyJ4NXQjUzI1NiI6IjJ5NERKRU1LTWk5V2JoOFF2VFV1cGgtdUIzNF81eDcweXp3dXFiSGpYRjQiLCJ4iMWpnN251eUJmVW5vWFQ4WnUxNnMiLCJraWQiOiJTSUdOSU5HX0tFWSIsImFsZyI6IlJTMjU2In0.eyJ1c2VyX3R6IjoiQW1lcmljYVwvQ2hpY2FnbyIsInN1YiI6ImFtaXQudHlhZ2lAb3JhY2xlLmNvbSIsInVzZXJfbG9jYWxlIjoiZW4iLCJpZHBfbmFtZSI6ImxvY2FsSURQIiwidXNlci50ZW5hbnQubmFtZSI6ImlkY3MtOWE4ZTgxNzI0ODdhNDg4MTkyMzgzMDk0MTkwZWMwNGMiLCJvbkJlaGFsZk9mVXNlciI6dHJ1ZSwiaWRwX2d1aWQiOiJsb2NhbElEUCIsImFtciI6WyJVU0VSTkFNRV9QQVNTV09SRCJdLCJpc3MiOiJodHRwczpcL1wvaWRlbnRpdHkub3JhY2xlY2xvdWQuY29tXC8iLCJ1c2VyX3RlbmFudG5hbWUiOiJpZGNzLTlhOGU4MTcyNDg3YTQ4ODE5MjM4MzA5NDE5MGVjMDRjIiwiY2xpZW50X2lkIjoidG9rZW5HZW5lcmF0b3IiLCJ1c2VyX2lzQWRtaW4iOnRydWUsInN1Yl90eXBlIjoidXNlciIsInNjb3BlIjoidXJuOm9wYzppZG06Zy5pZGVudGl0eXNvdXJjZXRlbXBsYXRlX3IgdXJuOm9wYzppZG06dC5ncm91cHMubWVtYmVyc19yIHVybjpvcGM6aWRtOnQuZ3JvdXBzLm1lbWJlcnMgdXJuOm9wYzppZG06dC5hcHAgdXJuOm9wYzppZG06dC51c2VyLmxvY2tlZHN0YXRlY2hhbmdlciB1cm46b3BjOmlkbTp0LmlkYnJpZGdlLmFkbWluIHVybjpvcGM6aWRtOnQudGVybXNvZnVzZSB1cm46b3BjOmlkbTp0LmlkY3NycHRzIHVybjpvcGM6aWRtOnQucmVxdWVzdHMgdXJuOm9wYzppZG06dC51c2VyLm1hbmFnZXIgdXJuOm9wYzppZG06dC5oZWxwZGVzay5zZWN1cml0eSB1cm46b3BjOmlkbTp0LnNlY3VyaXR5LmNsaWVudCB1cm46b3BjOmlkbTpnLmFwcHRlbXBsYXRlX3IgdXJuOm9wYzppZG06dC5idWxrLnVzZXIgdXJuOm9wYzppZG06dC5kaWFnbm9zdGljc19yIHVybjpvcGM6aWRtOnQuaWRiX2NvbnRhaW5lcnMgdXJuOm9wYzppZG06dC5pZGJyaWRnZS51c2VyIHVybjpvcGM6aWRtOnQudXNlci5tZSB1cm46b3BjOmlkbTpnLmFsbF9yIHVybjpvcGM6aWRtOnQuaWRicmlkZ2VfciB1cm46b3BjOmlkbTp0Lm1mYV9yIHVybjpvcGM6aWRtOnQudXNlci5zZWN1cml0eSB1cm46b3BjOmlkbTp0Lmdyb3Vwc19yIHVybjpvcGM6aWRtOnQuYXVkaXRfciB1cm46b3BjOmlkbTp0LmpvYi5hcHAgdXJuOm9wYzppZG06dC51c2Vyc19yIHVybjpvcGM6aWRtOnQuc29taSB1cm46b3BjOmlkbTpnLnNoYXJlZGZpbGVzIHVybjpvcGM6aWRtOnQuaGVscGRlc2sudXNlciB1cm46b3BjOmlkbTp0LnJlcy5pbXBvcnRleHBvcnQgdXJuOm9wYzppZG06dC5qb2IuaWRlbnRpdHkgdXJuOm9wYzppZG06dC5jdXN0b21jbGFpbXMgdXJuOm9wYzppZG06dC5zYW1sIHVybjpvcGM6aWRtOnQubWZhIHVybjpvcGM6aWRtOnQuZGIuYWRtaW4gdXJuOm9wYzppZG06dC5zY2hlbWFzIHVybjpvcGM6aWRtOnQubWZhLnVzZXJhZG1pbiB1cm46b3BjOmlkbTp0LnVzZXIubWFuYWdlci5qb2IgdXJuOm9wYzppZG06dC5jbG91ZGdhdGVfciB1cm46b3BjOmlkbTp0Lm9hdXRoIHVybjpvcGM6aWRtOnQuZ3JvdXBzIHVybjpvcGM6aWRtOnQuam9iLmltcG9ydGV4cG9ydCB1cm46b3BjOmlkbTp0LmlkYnJpZGdlLnVubWFwcGVkLmlkY3NhdHRyaWJ1dGVzIHVybjpvcGM6aWRtOnQua3JiLmFkbWluIHVybjpvcGM6aWRtOnQubmFtZWRhcHBhZG1pbiB1cm46b3BjOmlkbTp0LmJsa3JwdHMgdXJuOm9wYzppZG06dC5zZWxmcmVnaXN0cmF0aW9ucHJvZmlsZSB1cm46b3BjOmlkbTp0LmdyYW50cyB1cm46b3BjOmlkbTp0LnVzZXIuYXV0aGVudGljYXRlIHVybjpvcGM6aWRtOnQuYXV0aGVudGljYXRpb24gdXJuOm9wYzppZG06dC5jb250YWluZXIgdXJuOm9wYzppZG06dC5pbWFnZXMgdXJuOm9wYzppZG06dC5idWxrIHVybjpvcGM6aWRtOnQuZGVsZWdhdGVkLmdyb3VwLm1lbWJlcnMgdXJuOm9wYzppZG06dC5qb2Iuc2VhcmNoIHVybjpvcGM6aWRtOnQuaWRicmlkZ2UgdXJuOm9wYzppZG06dC5zZXR0aW5ncyB1cm46b3BjOmlkbTp0LnVzZXIubWFuYWdlci5zZWN1cml0eSB1cm46b3BjOmlkbTp0LmNsb3VkZ2F0ZSB1cm46b3BjOmlkbTp0LmlkYnJpZGdlLnNvdXJjZWV2ZW50IHVybjpvcGM6aWRtOnQuaWRiX2NvbnRhaW5lcnNfciB1cm46b3BjOmlkbTp0LnBvbGljeSB1cm46b3BjOmlkbTp0LnVzZXJzIHVybjpvcGM6aWRtOnQucmVwb3J0cyB1cm46b3BjOmlkbTpnLmlkY3NycHRzbWV0YV9yIHVybjpvcGM6aWRtOnQuYWRhcHRpdmVfciIsImNsaWVudF90ZW5hbnRuYW1lIjoiaWRjcy1vcmFjbGUiLCJ1c2VyX2xhbmciOiJlbiIsInVzZXJBcHBSb2xlcyI6WyJVc2VyIEFkbWluaXN0cmF0b3IiLCJBdXRoZW50aWNhdGVkIiwiR2xvYmFsIFZpZXdlciIsIklkZW50aXR5IERvbWFpbiBBZG1pbmlzdHJhdG9yIiwiQXVkaXQgQWRtaW5pc3RyYXRvciIsIkFwcGxpY2F0aW9uIEFkbWluaXN0cmF0b3IiLCJTZWN1cml0eSBBZG1pbmlzdHJhdG9yIl0sImV4cCI6MTYwMTU3MjI0NSwiaWF0IjoxNjAxNTQzNTkyLCJjbGllbnRfZ3VpZCI6IjczYjliYWNmY2U2MDQ0NzU5OWNlZmE4ZmY2YjA5ODc3IiwiY2xpZW50X25hbWUiOiJ0b2tlbkdlbmVyYXRvciIsImlkcF90eXBlIjoiTE9DQUwiLCJ0ZW5hbnQiOiJpZGNzLTlhOGU4MTcyNDg3YTQ4ODE5MjM4MzA5NDE5MGVjMDRjIiwianRpIjoiYjJmMWQwYzItNzJhNy00MTYyLTlkMTItNzcxNGNmODY4MTc4IiwidXNlcl9kaXNwbGF5bmFtZSI6IkFtaXQgVHlhZ2kiLCJzdWJfbWFwcGluZ2F0dHIiOiJ1c2VyTmFtZSIsInByaW1UZW5hbnQiOnRydWUsInRva190eXBlIjoiQVQiLCJjYV9ndWlkIjoiY2FjY3QtYzk3ZGY4M2VhMWQwNGZjZThmOGMwYWU5ODI0N2Y4NzciLCJhdWQiOlsiaHR0cHM6XC9cL2lkY3MtOWE4ZTgxNzI0ODdhNDg4MTkyMzgzMDk0MTkwZWMwNGMuaWRlbnRpdHkub3JhY2xlY2xvdWQuY29tOjQ0MyIsInVybjpvcGM6bGJhYXM6bG9naWNhbGd1aWQ9aWRjcy05YThlODE3MjQ4N2E0ODgxOTIzODMwOTQxOTBlYzA0YyIsImh0dHBzOlwvXC9pZGNzLTlhOGU4MTcyNDg3YTQ4ODE5MjM4MzA5NDE5MGVjMDRjLmlkZW50aXR5Lm9yYWNsZWNsb3VkLmNvbSJdLCJ1c2VyX2lkIjoiMjc1M2RhZDU5ZDUwNGVkNTkzNThhNTg0OTJjNzk5YjYiLCJjbGllbnRBcHBSb2xlcyI6WyJBdXRoZW50aWNhdGVkIENsaWVudCIsIkNyb3NzIFRlbmFudCJdLCJ0ZW5hbnRfaXNzIjoiaHR0cHM6XC9cL2lkY3MtOWE4ZTgxNzI0ODdhNDg4MTkyMzgzMDk0MTkwZWMwNGMuaWRlbnRpdHkub3JhY2xlY2xvdWQuY29tOjQ0MyJ9.K9L6vKtt7PUaJFKYUBvXPKTWnz8QjmC-HGFHUU9sJGD-fNo0fGGlvCHwt33i4njHucEvSNE3Ww360TIxl0dSwm4WPMo4-TIgHyZKzHbkSZs5DcUOB1a043nkH9h63MJ4aBNzWzojmrXGUIYMok6RRacVKTMrWgiVt_1TEHZM8DhElWKFI4GNrANqNYqdy8D_sJ5_23U6RjDKpIZj3tD3YamoYbz5e0In8YpBdOn9zVePWVcVwa-Wfri9guURgAP5XoeKdht0ejA75s9GNgxFC7K4de0Q14tQmYWfDD5U0-wYeOiBFe5sDL5FFkzIZFfmihV9zl_cjSYwMIG60oJZaA"


## RDG Compute

rdg_custom_image = "ocid1.image.oc1.iad.aaaaaaaa5yswvktwwqyalt46w5djhnwytpruw2aopqci5cq4ky45t3mtafdq"
rdg_compute_shape = "VM.Standard2.1"
rdg_compute_shape_prod = "VM.Standard2.2"
rdg_ssh_pub_key="ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAgz2c+ahjeJPTjnypdl/4EIUMe7M5qSQvK5qUn6gwwTmD+bisDA5F7xST6HaUdHGIyM/oBcZSJfEeraGOHB7iixdNcPnvF9vlhFwnJ3HzoqCRRL1HNdbY8rqj4qeMWEO++ZmCCqrEwAxeZyycPHc3GZTxu/ekLwo2rRna3pHEa3paCrw2Bng+dRgYyV2Y2UzRGB6tyc2XE1vioUiEH5WwB/10BBlhVUHsgOXXgvAEbshCUbwf/MIuiOWnDLOkuM4B//EUA9/2Yva6xcnufZd3mwL3tgjifVn/1wzIxfLQBNRL6G8hjtJ5PG/J+TcjC55qwGO3qqDw== rsa-key-20200402"

## Bastion

bastion_compute_shape = "VM.Standard2.1"
bastion_image_id ="ocid1.image.oc1.iad.aaaaaaaa7loygdwzmew3hud3bqjyzamzqnz3krpiuhjb3z3u5s3hmmtar6mq" ## get image ocid from https://docs.cloud.oracle.com/en-us/iaas/images/image/96068886-76e5-4a48-af0a-fa7ed8466a25/

