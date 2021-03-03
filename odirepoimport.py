#########################################################################################################################################
#   File :- odiexpport.py
#   Description :- Export ODI repository from OCI Classic Environment
#   Date :- 09-Nov-2020
#   Author :- Amit Tyagi
#   Prerequisites :- 1. Create Directories in DB for e.g. CREATE DIRECTORY DBIMPORT AS '/u01/app/oracle/dbexport';
#   2. Get Oracle User VM Access 
#   3. Create Table Space and Temp Tablespace on DB as shown below
#   CREATE TABLESPACE OCI_ODI_USER 
#   DATAFILE 'tbs1_data.dbf' 
#   SIZE 1024m;
#   
#   CREATE TEMPORARY TABLESPACE OCI_ODI_TEMP 
#   TEMPFILE 'tbs3_temp.dbf' 
#    SIZE 200m ;
###########################################################################################################################################

import paramiko
import odiconfig

print("***********************************************************************************")
print("*                                                                                 *")
print("*                        ODI REPOSITORY IMPORT STARTED                            *")
print("*                                                                                 *")
print("***********************************************************************************")

try:
    ssh_bastion=paramiko.SSHClient()
    ssh_bastion.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_bastion.connect(hostname=odiconfig.oci_bastion_host, username="opc",key_filename=odiconfig.oci_bastion_host_key)
    print("*********************** Connected to Bastion HOST ************************************")
    
    ssh_transport=ssh_bastion.get_transport()
    dest_addr=(odiconfig.oci_repo_db_host,22)
    source_addr=(odiconfig.oci_bastion_host,22)
    ssh_channel=ssh_transport.open_channel("direct-tcpip",dest_addr,source_addr)

    ssh_target=paramiko.SSHClient()
    ssh_target.set_missing_host_key_policy(paramiko.AutoAddPolicy)
    ssh_target.connect(hostname=odiconfig.oci_repo_db_host, username=odiconfig.oci_repo_db_username, key_filename=odiconfig.oci_repo_db_key, sock=ssh_channel)
    print("*********************** Connected to Database Server************************************")
    
    cmd="impdp \\\"sys/%s@%s as sysdba\\\" schemas=%s directory=%s dumpfile=%s.dmp logfile=%s.log REMAP_SCHEMA=%s:%s REMAP_TABLESPACE=%s:%s,%s:%s EXCLUDE=STATISTICS IGNORE=Y" %(odiconfig.oci_repo_db_schema_pwd,odiconfig.oci_repo_db_sid,odiconfig.ocic_repo_db_schema,odiconfig.oci_db_dir,odiconfig.ocic_repo_db_schema,odiconfig.oci_repo_db_schema,odiconfig.ocic_repo_db_schema,odiconfig.oci_repo_db_schema,odiconfig.ocic_repo_db_tablespace,odiconfig.oci_repo_db_tablespace,
    odiconfig.ocic_repo_db_tmp_tablespace,odiconfig.oci_repo_db_tmp_tablespace)
    print("*********************** Running Datapump Import Command as shown below ************************************")
    print(cmd)

    ssh_stdin, ssh_stdout, ssh_stderr = ssh_target.exec_command(cmd)

    for line in ssh_stdout.readlines():
        print(line)
        
    for line in ssh_stderr.readlines():
        print(line)

    ssh_stdin.close()
    ssh_bastion.close()
except:
    print("************Some Exception Occured in ODI Repository Import***************")
    raise