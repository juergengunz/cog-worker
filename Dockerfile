ARG COG_REPO
ARG COG_MODEL
ARG COG_VERSION

FROM r8.im/juergengunz/flux-dev-lora-a40@sha256:a3eccc8cdd17467c09a2b0a7429744819cc5bffe130f8f1cc178e3a8992d57c0

ENV DEBIAN_FRONTEND=noninteractive
ENV RUNPOD_REQUEST_TIMEOUT=600

# The traceback shows that the cog server runs in a pyenv environment.
# We must use the pip from that specific environment to upgrade the correct cog package.
RUN /root/.pyenv/versions/3.10.18/bin/pip install --upgrade runpod cog

ADD src/handler.py /rp_handler.py

# Run the handler with the python from the base image.
CMD ["python", "-u", "/rp_handler.py"]