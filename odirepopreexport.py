#########################################################################################################################################
#   File :- odirepopreexpport.py
#   Description :- Create Export Directory in OCI  Classic ODI Repo Database.
#   Date :- 28-Jan-2021
#   Author :- Amit Tyagi
#   Prerequisites :- Get Oracle User ODI REPO DB VM Access   
#
###########################################################################################################################################

import os
import cx_Oracle
import sshtunnel
import odiconfig
import datetime

print("***********************************************************************************")
print("*                                                                                 *")
print("*                        ODI EXPORT PREREQUISITES STARTED                         *")
print("*                                                                                 *")
print("***********************************************************************************")
try:
    with sshtunnel.SSHTunnelForwarder(
                                    (odiconfig.oci_bastion_host,22), 
                                    ssh_username=odiconfig.ocic_repo_os_username,
                                    ssh_pkey=odiconfig.oci_bastion_host_key,
                                    remote_bind_address=(odiconfig.ocic_repo_db_host,1521)) as server:
                                print("******************** SSH Tunnel Established with OCI-C Repository Database Server *************************") 
                
                                dsn_tns=cx_Oracle.makedsn("127.0.0.1",server.local_bind_port,service_name=odiconfig.ocic_repo_db_service)               
                                conn=cx_Oracle.connect("sys",odiconfig.ocic_repo_db_sys_pwd, dsn_tns, mode=cx_Oracle.SYSDBA)  
                                cursor=conn.cursor()
                                print("************ OCI-C ODI Repository Database Connected *******************")
                                
                                sql2="CREATE DIRECTORY " +odiconfig.ocic_db_dir+ " AS " "'"+odiconfig.ocic_db_dir_path +"'"
                                print(sql2)
                                # Directory Creation      
                                dir="SELECT * FROM DBA_DIRECTORIES WHERE DIRECTORY_NAME=" "'"+odiconfig.ocic_db_dir+"'"
                                cursor.execute(dir)
                                row = cursor.fetchone()
                                if row == None:
                                        cursor.execute(sql2)
                                        print("************ Export Directory Created on Target Repository Database *******************")
                                else:
                                        print("************ Directory Alreday Exists *******************")
    
                                cursor.close()
                                conn.close()
                                
except:
    print("************Some Exception Occured in ODI PRE EXPORT ***************")
    raise