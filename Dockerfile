FROM ubuntu:latest

# Create the coder user
RUN useradd -m -s /bin/bash coder && \
    echo 'coder:codeserver' | chpasswd && \
    usermod -aG sudo coder

RUN echo 'root:codeserver' | chpasswd

# Update packages and install necessary tools
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    sudo \
    nano \
    openjdk-8-jdk \
    python3 \
    python3-pip \
    nodejs

# Install Visual Studio Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sudo -E bash -

# Set environment for the "coder" user
ENV HOME=/home/coder

USER coder

# Create the workspace directory
RUN mkdir -p /home/coder/project

# Start code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:8081", "--auth", "none", "/home/coder/project"]
