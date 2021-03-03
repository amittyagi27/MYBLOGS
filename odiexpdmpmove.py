###############################################################################################################
#   File :- odiexpdmpmove.py
#   Description :- Move ODI Repository Export Dump File to ODI Target Repository DB VM
#   Date :- 25-Feb-2021
#   Author :- Amit Tyagi
#   Prerequisites :- Bastion to OCIC Repo DB and OCI Repo DB Connectivity;
###################################################################################################################

import paramiko
import odiconfig
import datetime

print("*******************************************************************************************************")
print("*                                                                                                     *")
print("                             ODI MOVING REPOSITORY EXPORT FILE TO TARGET ODI DATABASE VM              *")
print("*                                                                                                     *")
print("*******************************************************************************************************")
try:
    ssh_bastion=paramiko.SSHClient()
    ssh_bastion.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_bastion.connect(hostname=odiconfig.oci_bastion_host, username="opc",key_filename=odiconfig.oci_bastion_host_key)
    print("*********************** Connected to Bastion HOST ************************************")
    
    cmd1="scp -i ~/.ssh/%s %s@%s:%s/%s.dmp /home/opc/"%(odiconfig.ocic_bastion_to_db_key,odiconfig.ocic_repo_db_username,odiconfig.ocic_repo_db_host,odiconfig.ocic_db_dir_path,odiconfig.ocic_repo_db_schema)
        
    print("*********************** Moving Export File to Bastion Host*************************************")
    print(cmd1)

    ssh_stdin, ssh_stdout, ssh_stderr = ssh_bastion.exec_command(cmd1)
    for line in ssh_stdout.readlines():
            print(line)
        
    for line in ssh_stderr.readlines():
            print(line)

    ssh_stdin.close()
    
    cmd2="scp -i ~/.ssh/%s /home/opc/%s.dmp %s@%s:%s"%(odiconfig.oci_bastion_to_db_key,odiconfig.ocic_repo_db_schema,odiconfig.oci_repo_db_username,odiconfig.oci_repo_db_host,odiconfig.oci_db_dir_path)
        
    print("*********************** Moving Export File to Target ODI DB VM *************************************")
    print(cmd2)

    ssh_stdin, ssh_stdout, ssh_stderr = ssh_bastion.exec_command(cmd2)
    for line in ssh_stdout.readlines():
            print(line)
        
    for line in ssh_stderr.readlines():
            print(line)

    ssh_stdin.close()
    ssh_bastion.close()
except:
    print("************Some Exception Occured in MOVING REPOSITORY EXPORT FILE***************")
    raise