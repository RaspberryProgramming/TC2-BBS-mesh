# From original Dockerfile at https://github.com/TheCommsChannel/TC2-BBS-mesh
FROM --platform=$BUILDPLATFORM python:3.13.9-alpine

# Switch to non-root user
RUN adduser --disabled-password mesh
USER mesh
RUN mkdir -p /home/mesh/bbs
WORKDIR /home/mesh/bbs

# Install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir --break-system-packages -r requirements.txt

# Copy over app code
COPY src/ ./
COPY fortunes.txt ./fortunes.txt

# Define config volume
VOLUME /home/mesh/bbs/config
WORKDIR /home/mesh/bbs/config
COPY example_config.ini ./config.ini
COPY fortunes.txt ./fortunes.txt 

# Define the command to run
ENTRYPOINT [ "python3", "/home/mesh/bbs/server.py" ]
