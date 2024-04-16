#!/bin/bash
###################################################################
#Script Name	: start_fb_worker_linux.sh                                                                                          
#Description	: script to start fb-worker depedencies in linux machines                                                                               
#Args           : N/A                                                                                        
#Author       	: Kannappan Chidambaram
#Email         	: kannappan.chidambaram@e5.ai                                         
###################################################################


RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
NC="\033[0m"

printf "\n"
printf "${YELLOW}*************** started : fb-worker execution *************** \n"
printf "${NC}\n"


# execute_fb_worker.sh : script to start fb-worker
# No Pre-requisites Check

conda_env_name=fb_worker_env
command_topic_name=command_topic
event_topic_name=event_topic


if [[ -z "${KAFKA_HOME}" ]]; then
	echo "${RED} ❌ Envrionment variable: KAFKA_HOME is not set or having empty value, please set this environment variable  before proceeding further"
	read -p "Press any key to exit . . "
    exit 1
else
	printf "${GREEN} ✔ environment variable : KAFKA_HOME is set"
fi

printf "${NC}\n"

# if [[ -z "${CONDA_HOME}" ]]; then
# 	echo "${RED} ❌ Envrionment variable: CONDA_HOME is not set or having empty value, please set this environment variable  before proceeding further (eg - C:\\ProgramData\\anaconda3)"
# 	read -p "Press any key to exit . . "
#     exit 1
# else
# 	printf "${GREEN} ✔ environment variable : CONDA_HOME is set"
# fi

# printf "${NC}\n"



printf "${GREEN} ✔ completed : validating pre-requisite checks\n"
printf "${NC}\n"


export KAFKA_CONSUMER_TOPIC=${event_topic_name}
export KAFKA_PRODUCER_TOPIC=${command_topic_name}
export KAFKA_BOOTSTRAP_SERVERS="localhost:9092"
export APP_URL="https://www.google.com"

# Create Command Topic
printf "${BLUE} ⏳ Create: Command Topic \n"
printf "${NC}\n"
gnome-terminal --title="Command_Topic" -- bash -c "${KAFKA_HOME}/bin/kafka-topics.sh --create --topic ${KAFKA_PRODUCER_TOPIC} --bootstrap-server localhost:9092"

sleep 10
# Write content to the file
printf "${GREEN} ✔ Command Topic Created successfully \n"
printf "${NC}\n"

# Create Event Topic
printf "${BLUE} ⏳ Create: Event Topic \n"
printf "${NC}\n"
gnome-terminal --title="Event_Topic" -- bash -c "${KAFKA_HOME}/bin/kafka-topics.sh --create --topic ${KAFKA_CONSUMER_TOPIC} --bootstrap-server localhost:9092"

sleep 10
# Write content to the file
printf "${GREEN} ✔ Event Topic Created successfully \n"
printf "${NC}\n"



# Start Kafka consumer process
printf "${BLUE} ⏳ Start: Kafka consumer process \n"
printf "${NC}\n"
gnome-terminal --title="Consumer_Process" -- bash -c "${KAFKA_HOME}/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic ${KAFKA_CONSUMER_TOPIC}"

sleep 10
# Write content to the file
printf "${GREEN} ✔ Kafka consumer process started successfully \n"
printf "${NC}\n"

# Start Kafka producer process
printf "${BLUE} ⏳ Start: Kafka producer process \n"
printf "${NC}\n"
gnome-terminal --title="Producer_Process" -- bash -c "${KAFKA_HOME}/bin/kafka-console-producer.sh --bootstrap-server=localhost:9092 --topic ${KAFKA_PRODUCER_TOPIC}"

sleep 10
# Write content to the file
printf "${GREEN} ✔ Kafka producer process started successfully \n"
printf "${NC}\n"

printf "${YELLOW} 🥇 FB worker environment initialized successfully \n"
printf "${NC}\n"


cd code
python app.py

if [ $? -ne 0 ]
then
    echo "${RED} ❌ Python app.py script execution got completed with error , please find error details above"
    read -p "Press any key to exit . . "
    exit 1
fi

