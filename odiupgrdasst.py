##############################################################################################
#   File :- odiupgrdasst.py
#   Description :- Run ODI Upgrade Assistant
#   Date :- 09-Nov-2020
#   Author :- Amit Tyagi
#   Prerequisites :- 1. Create Upgrade Assistant Response file 2. Put response file on ODI VM and note the path
##############################################################################################

import paramiko
import odiconfig

print("***********************************************************************************")
print("*                                                                                 *")
print("*                        ODI UPGRADE ASSISTANT STARTED                            *")
print("*                                                                                 *")
print("***********************************************************************************")
try:
    ssh_bastion=paramiko.SSHClient()
    ssh_bastion.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_bastion.connect(hostname=odiconfig.oci_bastion_host, username="opc",key_filename=odiconfig.oci_bastion_host_key)
    print("*********************** Connected to Bastion HOST ************************************")
    
    ssh_transport=ssh_bastion.get_transport()
    dest_addr=(odiconfig.oci_odi_compute_host,22)
    source_addr=(odiconfig.oci_bastion_host,22)
    ssh_channel=ssh_transport.open_channel("direct-tcpip",dest_addr,source_addr)

    ssh_target=paramiko.SSHClient()
    ssh_target.set_missing_host_key_policy(paramiko.AutoAddPolicy)
    ssh_target.connect(hostname=odiconfig.oci_bastion_host, username=odiconfig.oci_odi_vm_username, key_filename=odiconfig.oci_odi_vm_key, sock=ssh_channel)
    print("*********************** Connected to ODI Server ************************************")
    
    cmd1="cd %s/oracle_common/upgrade/bin" %(odiconfig.oci_odi_oracle_home)
    cmd2= "./ua -response %s -logLevel TRACE -logDir %s" %(odiconfig.oci_odi_response_file,odiconfig.oci_odi_log_dir)
    
    print("*********************** This is ODI Upgrade Assistant Directory ************************************")
    print(cmd1)
    print("*********************** ODI Upgrade Assistant Command ************************************")
    print(cmd2)

    ssh_stdin, ssh_stdout, ssh_stderr = ssh_target.exec_command(cmd1 +";"+ cmd2 )
    for line in ssh_stdout.readlines():
            print(line)
        
    for line in ssh_stderr.readlines():
            print(line)

    ssh_stdin.close()
    ssh_bastion.close()
except:
    print("************ Some Exception Occured in ODI Upgrade Assistant ***************")
    raise