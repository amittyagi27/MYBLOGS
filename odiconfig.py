##############################################
#   File :- odiconfig.py
#   Description :- ODI Migration Config File
#   Date :- 28-Jan-2021
#   Author :- Amit Tyagi
###############################################

#Python
python_script_directory="/Users/amittyagi/Documents/Amit/Oraclework/PythonTraining/pythonproject"       ##Local Directory of Python Script

#Bastion Host
oci_bastion_host="00.00.00.00"                                       # ZDM/Bastion/Jumphost IP Address
oci_bastion_host_key="/Users/.ssh/mypvtkey"                          # Private SSH Key on local machine to access ZDM/Bastion/Jumphost Server
ocic_bastion_to_db_key="ssh_pvt_key"                                 # Private SSH Key in .ssh Directory on Bastion Host to access Source ODI Repository DB
oci_bastion_to_db_key="ssh_pvt_key"                                  # Private SSH Key in .ssh Directory on Bastion Host to access Target ODI Repository DB

##OCI Classic ODI Repo
ocic_repo_db_host="00.00.00.00"                                      # Source ODI Repository DB IP Address
ocic_repo_db_key="/Users/.ssh/mypvtkey"                              # Private SSH Key on Local Machine to access Source ODI Repository DB
ocic_repo_os_username="opc"                                          # Source ODI Repository DB OS User
ocic_repo_db_username="oracle"                                       # Source ODI Repository Database User   
ocic_repo_db_schema="DEV_ODI_REPO"                                   # Source ODI Repository Schema Name  
ocic_repo_db_sid="ORCL_PDB"                                          # Source ODI Repository Database SID  
ocic_repo_db_schema_pwd="password"                                   # Source ODI Repository Schema Password 
ocic_repo_db_sys_pwd="password"                                      # Source ODI Repository DB SYS Password
ocic_db_dir="DBEXPORT"                                               # Source ODI Repository Export Directory Name
ocic_db_dir_path="/u01/app/oracle/dbexport"                          # Source ODI Repository Export Directory Path
ocic_repo_db_tablespace="DEV_ODI_USER"                               # Source ODI Repository Schema Tablespace Name
ocic_repo_db_tmp_tablespace="DEV_ODI_TEMP"                           # Source ODI Repository Schema Temporary Tablespace Name
ocic_repo_db_service="pdb1.testpublicsu.testvcn.oraclevcn.com"       # Source ODI Repository Database Serrvice                                

#OCI ODI Repo
oci_repo_db_host="00.00.00.00"                                       # Target ODI Repository DB IP Address
oci_repo_db_key="/Users/.ssh/mypvtkey"                               # Private SSH Key on Local Machine to access Target ODI Repository DB
oci_repo_os_username="opc"                                           # Target ODI Repository DB OS User
oci_repo_db_username="oracle"                                        # Target ODI Repository Database User 
oci_repo_db_schema="OCI_ODI_REPO"                                    # Target ODI Repository Schema Name
oci_repo_db_schema_prefix="OCI"
oci_repo_db_sid="ORCL_PDB"                                           # Target ODI Repository Database SID  
oci_repo_db_schema_pwd="password"                                    # Target ODI Repository Schema Password 
oci_repo_db_sys_pwd="password"                                       # Target ODI Repository DB SYS Password
oci_db_dir="DBIMPORT"                                                # Target ODI Repository Import Directory Name
oci_db_dir_path="/u01/app/oracle/dbimport"                           # Target ODI Repository Import Directory Path
oci_repo_db_tablespace="OCI_ODI_USER"                                # Target ODI Repository Schema Tablespace Name
oci_repo_db_tmp_tablespace="OCI_ODI_TEMP"                            # Target ODI Repository Schema Temporary Tablespace Name
oci_repo_db_service="pdb1.testoacprivates.testoacvcn.oraclevcn.com"  # Target ODI Repository Database Serrvice  

#ODI Compute
oci_odi_compute_host="00.00.00.00"                                   # Target ODI Server IP Address
oci_odi_vm_username="oracle"                                         # Target ODI Server Oracle User name  
oci_odi_vm_key="/Users/.ssh/mypvtkey"                                # Private SSH Key on local machine to access ODI Server
oci_odi_response_file="/u01/oracle/NewFolder/responses.txt"          # Target ODI Server ODI Upgrade Assistant Response File
oci_odi_log_dir="/u01/oracle/NewFolder"                              # Target ODI Server ODI Upgrade Assistant Log File Location
oci_odi_oracle_home="/u01/oracle/mwh"                                # Target ODI Server Middleware Home Location              






