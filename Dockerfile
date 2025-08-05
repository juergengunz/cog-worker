ARG COG_REPO
ARG COG_MODEL
ARG COG_VERSION

FROM r8.im/juergengunz/flux-dev-lora-a40@sha256:a3eccc8cdd17467c09a2b0a7429744819cc5bffe130f8f1cc178e3a8992d57c0

ENV DEBIAN_FRONTEND=noninteractive
ENV RUNPOD_REQUEST_TIMEOUT=600

# Install necessary packages and Python 3.10
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends ca-certificates curl gnupg git openssh-server && \
    mkdir -p /etc/apt/keyrings && \
    curl -sS "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xBA6932366A755776" | gpg --dearmor -o /etc/apt/keyrings/deadsnakes-ppa.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/deadsnakes-ppa.gpg] https://ppa.launchpadcontent.net/deadsnakes/ppa/ubuntu jammy main" | tee /etc/apt/sources.list.d/deadsnakes-ppa.list > /dev/null && \
    apt-get update && \
    apt-get install -y --no-install-recommends python3.10 python3.10-dev python3.10-distutils && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 &&\
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py

# Create a virtual environment
RUN python3 -m venv /opt/venv

# Install runpod within the virtual environment
RUN /opt/venv/bin/pip install runpod

ADD src/handler.py /rp_handler.py

CMD ["/opt/venv/bin/python3", "-u", "/rp_handler.py"]