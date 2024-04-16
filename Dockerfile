ARG BASE_IMAGE=element5.jfrog.io/e5-rf-fb-base-image-docker-local/rf-fb-base:v0.0.2

FROM $BASE_IMAGE as builder
# 1: create an directory to move the source files

RUN mkdir -p rf

WORKDIR /rf

COPY . /rf

WORKDIR /rf/app/code/

# 2. Install the required packages like python, pip, robotframework, selenium, xvfb, firefox, chromium, geckodriver, chromedriver
RUN poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi

# 3. initialize the robotframework-browser

RUN rfbrowser init

# 4. install playwright with npx and do npm install

RUN PLAYWRIGHT_BROWSERS_PATH=$HOME/pw-browsers npx playwright install

# 4.`1 install npm packages
RUN npm install

# 5. entrypoint init shell script
ENTRYPOINT ["./init.sh"]