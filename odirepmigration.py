#################################################################################
#   File :- odirepmigration.py
#   Description :- Master Script for ODI repository Export,Move and Import.
#   Date :- 21-Jan-2021
#   Author :- Amit Tyagi
#   Prerequisites :- OCI Classic ODI Repo DB Access required from Bastion Host. 
##################################################################################
import os
import odiconfig
os.chdir(odiconfig.python_script_directory)

for script in ("odirepopreexport.py","odirepoexport.py","odiexpdmpmove.py","odirepopreimport.py","odirepoimport.py","odiregupdate.py") :
    with open(script) as f:
        contents=f.read()
    exec(contents)