# m8ttyb github ailoads-hello-world
FROM stackbrew/debian:testing

MAINTAINER Matt Brandt

RUN \
    apt-get update; \
    apt-get install -y python3-pip python3-venv git build-essential make; \
    apt-get install -y python3-dev libssl-dev libffi-dev; \
    git clone https://github.com/mozilla-services/ailoads-hello-world /home/hello_world; \
    cd /home/hello_world; \
    pip3 install virtualenv; \
    make build -e PYTHON=python3.5; \
	apt-get remove -y -qq git build-essential make python3-pip python3-venv libssl-dev libffi-dev; \
    apt-get autoremove -y -qq; \
    apt-get clean -y

WORKDIR /home/hello_world

# run the test
CMD venv/bin/ailoads -v # -d $LOOP_DURATION -u $LOOP_NB_USERS
