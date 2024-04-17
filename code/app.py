import re
import robot
import robot.libraries
import uuid
import time
import os
import signal
import subprocess
import sys
from robot.libraries.BuiltIn import BuiltIn
from datetime import datetime
from xvfbwrapper import Xvfb
import boto3

def xwininfo():
    subprocess.run(['wmctrl','-l'])


def upload_file_to_s3(file_name, s3_bucket=None, s3_key=None):
    s3_client = boto3.client('s3', aws_access_key_id=os.getenv('AWS_ACCESS_KEY_ID'), aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY'))
    try:
        current_date = datetime.today().strftime('%m%d%Y')
        
        s3_key = str(current_date) + '/{}'.format(str(file_name))
        #Todo: bucket name will be modified
        s3_client.upload_file(file_name, os.getenv("AWS_BUCKET_NAME"), s3_key)
        BuiltIn().log_to_console("File uploaded")
    except Exception as e:
        BuiltIn().log_to_console("Error uploading file to S3 bucket")

def get_window_geometry(window_name):
    cmd = ["wmctrl", "-l"]
    result = subprocess.run(cmd, capture_output=True, text=True)
    window_lines = result.stdout.strip().split('\n')
    window_id = None
    for line in window_lines:
        if line.strip().startswith(window_name):
            window_id = line.split()[0]
            break

    if window_id is None:
        BuiltIn().log_to_console(f"No window found with name starting with '{window_name}'.")
        return None

    # Get geometry of the window
    cmd = ["wmctrl", "-lG"]
    result = subprocess.run(cmd, capture_output=True, text=True)
    geometry_lines = result.stdout.strip().split('\n')
    for line in geometry_lines:
        if window_id in line:
            geometry = line.split()[2:6]  # x, y, width, height
            geometry = list(map(int, geometry))
            BuiltIn().log_to_console("window name: "+ str(window_name) + "geometry: " + str(geometry))
            return geometry

    BuiltIn().log_to_console("Failed to get geometry for window with name starting with" + str(window_name) + "")
    return None

def get_all_windows():
    # Get list of all windows
    cmd = ["wmctrl", "-l"]
    result = subprocess.run(cmd, capture_output=True, text=True)
    window_list = result.stdout.strip().split('\n')
    for window in window_list:
        BuiltIn().log_to_console(str(window))
    return window_list

def close_all_windows():
    # Get list of open windows
    cmd_list = ["wmctrl", "-l"]
    result = subprocess.run(cmd_list, capture_output=True, text=True)
    window_lines = result.stdout.strip().split('\n')

    # Close each window
    for line in window_lines:
        window_id = line.split()[0]
        subprocess.run(["wmctrl", "-ic", window_id])


def invoke_fb_worker():
    with open("message_out.log", "w") as log_file_out, open("message_err.log", "w") as log_file_err:
        # TODO: Add logic to decide at runtime if the Xvfb is required

        # vdisplay = Xvfb(width=1920, height=1080)
        # vdisplay.start()
        # pWM = subprocess.Popen(["/usr/bin/icewm"])
        run_result = robot.run("./robots/functionblocks/FB_AddCareCoordinationNotes.robot")
        # vdisplay.stop()
        # print(run_result)
        return run_result

if __name__ == '__main__':
        invoke_fb_worker()