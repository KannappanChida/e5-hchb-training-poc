''' Library Initialization code '''

import robot
from e5_rf_fb_worker_core.listeners.loglistener import loglistener

if __name__ == '__main__':
    run_result = robot.run("./robots/start.robot",listener=loglistener)