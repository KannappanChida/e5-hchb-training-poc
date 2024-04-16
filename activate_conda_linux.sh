#!/bin/bash
###################################################################
#Script Name	: activate_conda_linux.sh                                                                                          
#Description	: script to activate conda environment
#Args          : N/A                                                                                        
#Author       	: Kannappan Chidambaram
#Email         : kannappan.chidambaram@e5.ai                                         
###################################################################
conda_env_name=fb_worker_env

if conda env list | grep -q -e "$conda_env_name";
then
   printf "${GREEN} ✔ conda environment : ${conda_env_name} is available, activating it now..."
   conda deactivate
   conda activate ${conda_env_name}
else
  printf " ${RED} Conda environment : ${conda_env_name} is not found, please create this conda environment,  before proceeding further"
  read -p "Press any key to exit . . "
  exit 1
fi

if [ $? -ne 0 ]
then
    echo "${RED} ❌ Error while activating the conda environment"
    read -p "Press any key to exit . . "
    exit 1
fi

printf "${NC}\n"