@echo off

@REM # execute_fb_worker.sh : script to start fb-worker
@REM #
@REM # No Pre-requisites Check

ECHO *************** started : fb-worker execution ***************
ECHO.

SET "conda_env_name=fb_worker_env" > nul

conda env list | >nul find /i "%conda_env_name%" && set "check_env=0" || set "check_env=1"
IF "%check_env%" == "0" (
  @REM conda environment found
  ECHO %conda_env_name% environment exists, activating it now...
  CALL conda deactivate
  CALL conda activate %conda_env_name%
) ELSE (
  @REM conda environment not found
  Echo Conda environment : %conda_env_name% is not found, please create this conda environment,  before proceeding further
  ECHO Press any key to exit . . .
  pause > nul
)

SET "command_topic_name=command_topic" > nul
SET "event_topic_name=event_topic" > nul




@If Defined KAFKA_HOME (
    Echo environment variable : KAFKA_HOME is set
) Else (
    Echo Envrionment variable : KAFKA_HOME is not set or having empty value, please set this environment variable  before proceeding further
	ECHO Press any key to exit . . .
	pause > nul
)

setx KAFKA_CONSUMER_TOPIC %command_topic_name% > nul
setx KAFKA_PRODUCER_TOPIC %event_topic_name% > nul
setx KAFKA_BOOTSTRAP_SERVERS localhost:9092 > nul
setx APP_URL https://www.google.com > nul

REM Create Command Topic
echo Create: Command Topic
echo. 
start "Command_Topic" cmd /c "title Command_Topic && call %KAFKA_HOME%/bin/windows/kafka-topics.bat --create --topic %command_topic_name% --bootstrap-server localhost:9092"

REM Add a delay of 5 seconds (5000 milliseconds)
timeout /t 5 /nobreak
echo [X]  Command Topic Created successfully
echo.

REM Create Event Topic
echo Create: Event Topic
echo. 
start "Event_Topic" cmd /c "title Event_Topic && call %KAFKA_HOME%/bin/windows/kafka-topics.bat --create --topic %event_topic_name% --bootstrap-server localhost:9092"

REM Add a delay of 5 seconds (5000 milliseconds)
timeout /t 5 /nobreak
echo [X]  Event Topic Created successfully
echo.


REM Start Kafka Consumer
echo start: Kafka consumer process
echo. 
start "Kafka_Consumer" cmd /c "title Kafka_Consumer && call %KAFKA_HOME%/bin/windows/kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic %event_topic_name%"

REM Add a delay of 5 seconds (5000 milliseconds)
timeout /t 5 /nobreak
echo [X]  Kafka consumer started
echo.

REM Create Event Topic
echo start: Kafka producer process
echo. 
start "Kafka_Producer" cmd /c "title Kafka_Producer && call %KAFKA_HOME%/bin/windows/kafka-console-producer.bat --bootstrap-server=localhost:9092 --topic %command_topic_name%"

REM Add a delay of 5 seconds (5000 milliseconds)
timeout /t 5 /nobreak
echo [X]  Kafka producer started
echo.


cd code
python app.py

echo " *************** completed : fb-worker execution  *************** "