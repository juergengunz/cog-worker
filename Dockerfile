ARG COG_REPO
ARG COG_MODEL
ARG COG_VERSION

FROM r8.im/juergengunz/flux-dev-lora-a40@sha256:a3eccc8cdd17467c09a2b0a7429744819cc5bffe130f8f1cc178e3a8992d57c0

ENV DEBIAN_FRONTEND=noninteractive
ENV RUNPOD_REQUEST_TIMEOUT=600

# The base image already has a working Python environment.
# We just need to install the runpod library.
RUN python3 -m pip install runpod --upgrade

ADD src/handler.py /rp_handler.py

# Run the handler with the python from the base image.
CMD ["python3", "-u", "/rp_handler.py"]