##########################################################################################################################
#   File :- odiregupdate.py
#   Description :- Refer OCI-C Repository Database and add row in SYSTEM SCHEMA VERSION REGISTRY in Target OCI Repository Database
#   Date :- 28-Jan-2021
#   Author :- Amit Tyagi
#   Prerequisites :- Access of OCI-C Repo DB VM and OCI Repo DB VM from Bastion Host for Oracle Users.
###########################################################################################################################

import os
import cx_Oracle
import sshtunnel
import odiconfig
import datetime

print("***********************************************************************************")
print("*                                                                                 *")
print("*                        SYSTEM SCHEMA VERSION REGISTRY UPDATE STARTED            *")
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
                                print("************OCI-C Repository Database Connected *******************") 
                                sql="select * from schema_version_registry where owner=:owner"
                                cursor.execute(sql,owner=odiconfig.ocic_repo_db_schema)
    
                                for row in cursor:
                                    print("************ Database Record fetched from SYSTEM SCHEMA VERSION REGISTRY from OCI-C Repository Database *******************") 
                                    print(row)
                                cursor.close()
                                conn.close()
        

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
                                
                                regrec="SELECT * FROM SCHEMA_VERSION_REGISTRY WHERE OWNER=" "'"+odiconfig.oci_repo_db_schema+"'"
                                cursor.execute(regrec)
                                rowselect = cursor.fetchone()
                                if rowselect == None:       
                                    sql= "Insert into schema_version_registry (COMP_ID,COMP_NAME,MRC_NAME,MR_NAME,MR_TYPE,OWNER,VERSION,STATUS,UPGRADED,START_TIME,MODIFIED,EDITION) values (:1,:2,:3,:4,:5,:6,:7,:8,:9,:10,:11,:12)"
                                    sysdate= datetime.datetime.now()
                                    cursor.execute(sql,(row[0],row[1],odiconfig.oci_repo_db_schema_prefix,row[3],row[4],odiconfig.oci_repo_db_schema,row[6],row[7],row[8],row[9],sysdate,row[11]))
                                    conn.commit()
   
                                    print("************OCI TARGET Schema Version Registry Record Insertion Completed*******************") 
                                else:
                                    print("************OCI TARGET Schema Version Registry Record Already Exists *******************")
                                    
                                sql="select * from schema_version_registry where owner=:owner"
                                cursor.execute(sql,owner=odiconfig.oci_repo_db_schema)
                                for row in cursor:
                                    print("************ Database Record Inserted in SYSTEM SCHEMA VERSION REGISTRY in OCI Target Repository Database *******************") 
                                    print(row)
        
                                cursor.close()
                                conn.close()
except:
    print("************Some Exception Occured in SYSTEM SCHEMA VERSION REGISTRY UPDATE ***************")
    raise



    