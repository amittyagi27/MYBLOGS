#####################################################################
#	File Name 	:- Variable.Tf
#	Description :- This file contains all Terraform Variables
#	Developed by :- Amit Tyagi
#	Last Updated :- 11-Sep-2020
####################################################################


##General Variables

variable "Resource_prefix" {
  type        = string
  description = "provide value of Resource Prefix like customer name."
}

variable "Resource_suffix_dev" {
  type        = string
  description = "provide value of Resource Prefix like Environment name for e.g Dev, Prod."
}

variable "Resource_main" {
  type        = string
  description = "provide value of Resource Prefix like customer name."
}

## Provider Variables

variable "tenancy_ocid" {
  type        = string
  description = "provide value of Tenancy Id."
}

variable "user_ocid" {
  type        = string
  description = "provide value of user Id."
}

variable "fingerprint" {
  type        = string
  description = "provide value of fingerprint."
}

variable "private_key_path" {
  type        = string
  description = "provide value of private key."
}

variable "pass_phrase" {
  type        = string
  description = "provide value of pass_phrase."
}

variable "region" {
  type        = string
  description = "provide value of region"
}

variable "availability_domain" {
  type        = string
  description = "provide value of availability domain"
}


## Tenancy Compartments

variable "compartment_nonprod_ocid" {
  type        = string
  description = "provide value of compartment id for nonProduction"
}

variable "compartment_network_ocid" {
  type        = string
  description = "provide value of compartment id for preProduction"
}

## VCN Variables

variable "vcn_cidr" {
  type        = string
  description = "provide value of vcn cidr"
}

variable "vcn_dns_prefix" {
  type        = string
  description = "provide value of vcn Dns Prefix"
}

## Subnet

variable "subnet_dev_pub_cidr" {
  type        = string
  description = "provide value of public subnet cidr"
}

variable "subnet_dev_pvt_db_cidr" {
  type        = string
  description = "provide value of private subnet cidr"
}

variable "subnet_dev_pvt_app_cidr" {
  type        = string
  description = "provide value of private subnet cidr"
}

## Database

variable "database_admin_password" {
  type        = string
  description = "provide value of Database Password"
}

variable "database_db_unique_name" {
  type        = string
  description = "provide value of Database Unique Name"
}

variable "database_db_workload" {
  type        = string
  description = "provide value of Database workload"
}

variable "database_pdb_name" {
  type        = string
  description = "provide value of Database PDB Name"
}

variable "database_version" {
  type        = string
  description = "provide value of Database Version"
}

variable "database_shape" {
  type        = string
  description = "provide value of Database Shape"
}

variable "database_shape_prod" {
  type        = string
  description = "provide value of Database Shape for Production DB"
}

variable "database_storage" {
  type        = string
  description = "provide value of Database Storage"
}

variable "database_storage_prod" {
  type        = string
  description = "provide value of Database Storage for Production DB"
}

variable "database_edition" {
  type        = string
  description = "provide value of Database Edition"
}

variable "database_ssh_pub_key" {
  type        = string
  description = "provide value of Database Public SSH Key"
}

variable "database_nodecount" {
  type        = string
  description = "provide value of Database Node Count"
}

## OAC

variable "oac_capacity_type" {
  type        = string
  description = "provide value of OAC Capacity Type"
}

variable "oac_capacity_value" {
  type        = string
  description = "provide value of OAC Capacity Value"
}

variable "oac_capacity_value_prod" {
  type        = string
  description = "provide value of OAC Capacity Value for Production"
}

variable "oac_feature_set" {
  type        = string
  description = "provide value of OAC Feature set"
}

variable "oac_license_type" {
  type        = string
  description = "provide value of OAC Licence Type"
}

variable "oac_idcs_token" {
  type        = string
  description = "provide value of OAC IDCS Token"
}

#PAC

variable "oac_pac_domain_suffix" {
  type        = string
  description = "provide Suffix of OAC PAC Domain Name"
}

## Bastion Compute

variable "bastion_compute_shape" {
  type        = string
  description = "provide value of Bastion Compute Shape"
}

variable "bastion_image_id" {
  type        = string
  description = "provide value of Bastion Image ID"
}
variable "bastion_ssh_pub_key" {
  type        = string
  description = "provide value of Bastion SSH Public Key"
}