##########################################################################################################################
#   File :- odirepopreimport.py
#   Description :- Create Tablepaces and Import Directory for ODI Repository Import on Target Databse.
#   Date :- 28-Jan-2021
#   Author :- Amit Tyagi
#   Prerequisites :- Access of OCI Repo DB VM from Bastion Host for Oracle Users.
###########################################################################################################################

import os
import cx_Oracle
import sshtunnel
import odiconfig
import datetime

print("***********************************************************************************")
print("*                                                                                 *")
print("*                        ODI IMPORT PREREQUISITES STARTED                         *")
print("*                                                                                 *")
print("***********************************************************************************")
try:
    with sshtunnel.SSHTunnelForwarder(
                                    (odiconfig.oci_bastion_host,22), 
                                    ssh_username=odiconfig.oci_repo_os_username,
                                    ssh_pkey=odiconfig.oci_bastion_host_key,
                                    remote_bind_address=(odiconfig.oci_repo_db_host,1521)) as server:
    
                                print("******************** SSH Tunnel Established with OCI Target Repository Database Server *************************") 
                
                                dsn_tns=cx_Oracle.makedsn("127.0.0.1",server.local_bind_port,service_name=odiconfig.oci_repo_db_service)               
                                conn=cx_Oracle.connect("sys",odiconfig.oci_repo_db_sys_pwd, dsn_tns, mode=cx_Oracle.SYSDBA) 
                                cursor=conn.cursor()
                                print("************OCI Target Repository Database Connected *******************")
                                
                                sql="CREATE TABLESPACE " +odiconfig.oci_repo_db_tablespace+ " DATAFILE 'odi_data.dbf' SIZE 1024m reuse AUTOEXTEND ON"
                                sql1="CREATE TEMPORARY TABLESPACE " +odiconfig.oci_repo_db_tmp_tablespace+ " TEMPFILE 'odi_temp.dbf' SIZE 1024m reuse AUTOEXTEND ON"
                                sql2="CREATE DIRECTORY " +odiconfig.oci_db_dir+ " AS " "'"+odiconfig.oci_db_dir_path +"'"
                                
                                # USER Tablespace Creation
                                tbls="SELECT * FROM DBA_TABLESPACES WHERE TABLESPACE_NAME=" "'"+odiconfig.oci_repo_db_tablespace+"'"
                                cursor.execute(tbls)
                                row = cursor.fetchone()
                                if row == None:
                                     cursor.execute(sql)
                                     print("************ Tablespace Created on Target Repository Database Connected *******************")
                                else:
                                     print("************ Tablespace Alreday Exists *******************")
                                
                                 # TEMP Tablespace Creation 
                                tmptbls="SELECT * FROM DBA_TABLESPACES WHERE TABLESPACE_NAME=" "'"+odiconfig.oci_repo_db_tmp_tablespace+"'" 
                                cursor.execute(tmptbls)
                                row = cursor.fetchone()
                                if row == None:
                                     cursor.execute(sql1)
                                     print("************ Temporary Tablespace Created on Target Repository Database Connected *******************")
                                else:
                                     print("************ Temporary Tablespace Alreday Exists *******************")
                                     
                                # Directory Creation      
                                dir="SELECT * FROM DBA_DIRECTORIES WHERE DIRECTORY_NAME=" "'"+odiconfig.oci_db_dir+"'"
                                cursor.execute(dir)
                                row = cursor.fetchone()
                                if row == None:
                                    cursor.execute(sql2)
                                    print("************ Import Directory Created on Target Repository Database Connected *******************")
                                else:
                                     print("************ Directory Alreday Exists *******************")
    
                                cursor.close()
                                conn.close()
                                
except:
    print("************Some Exception Occured in ODI PRE IMPORT ***************")
    raise