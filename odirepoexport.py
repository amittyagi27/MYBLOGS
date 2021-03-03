#################################################################################
#   File :- odiexpport.py
#   Description :- Export ODI repository from OCI Classic Environment
#   Date :- 09-Nov-2020
#   Author :- Amit Tyagi
#   Prerequisites :- 1. Create Directories in DB for e.g. CREATE DIRECTORY DBEXPORT AS '/u01/app/oracle/dbexport';
##################################################################################

import paramiko
import odiconfig
import datetime

print("***********************************************************************************")
print("*                                                                                 *")
print("*                        ODI REPOSITORY EXPORT STARTED                            *")
print("*                                                                                 *")
print("***********************************************************************************")
try:
    ssh_bastion=paramiko.SSHClient()
    ssh_bastion.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_bastion.connect(hostname=odiconfig.oci_bastion_host, username="opc",key_filename=odiconfig.oci_bastion_host_key)
    print("*********************** Connected to Bastion HOST ************************************")

    ssh_transport=ssh_bastion.get_transport()
    dest_addr=(odiconfig.ocic_repo_db_host,22)
    source_addr=(odiconfig.oci_bastion_host,22)
    ssh_channel=ssh_transport.open_channel("direct-tcpip",dest_addr,source_addr)

    ssh_target=paramiko.SSHClient()
    ssh_target.set_missing_host_key_policy(paramiko.AutoAddPolicy)
    ssh_target.connect(hostname=odiconfig.ocic_repo_db_host, username=odiconfig.ocic_repo_db_username, key_filename=odiconfig.ocic_repo_db_key, sock=ssh_channel)
    print("*********************** Connected to Database Server************************************")
    
    sysdate= datetime.datetime.now()
    filetime = sysdate.strftime("%d%m%Y%H%M%S") ## Use this variable with File name if want to append datetime with file.
   
    cmd="expdp \\\"sys/%s@%s as sysdba\\\" schemas=%s directory=%s dumpfile=%s.dmp logfile=%s.log compression=all" %(odiconfig.ocic_repo_db_schema_pwd,odiconfig.ocic_repo_db_sid,odiconfig.ocic_repo_db_schema,odiconfig.ocic_db_dir,odiconfig.ocic_repo_db_schema,odiconfig.ocic_repo_db_schema)
    print("*********************** Running Datapump Export Command as shown below ************************************")
    print(cmd)

    ssh_stdin, ssh_stdout, ssh_stderr = ssh_target.exec_command(cmd)
    for line in ssh_stdout.readlines():
            print(line)
        
    for line in ssh_stderr.readlines():
            print(line)

    ssh_stdin.close()
    ssh_bastion.close()
except:
    print("************Some Exception Occured in ODI Repository Export***************")
    raise