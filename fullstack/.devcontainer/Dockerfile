# See here for image contents: https://github.com/microsoft/vscode-dev-containers/blob/main/containers/go/.devcontainer/Dockerfile
ARG BASE="debian-12"
FROM mcr.microsoft.com/devcontainers/base:${BASE}

# Install standard packages
RUN apt-get clean && \
    apt-get update && \
        # General purpose tools
    apt-get install -y \
        # Python
        libsasl2-dev libldap2-dev libssl-dev libsnmp-dev libffi-dev \
        libncurses-dev libsqlite3-dev libbz2-dev libreadline-dev liblzma-dev tzdata

# Set general-purpose environment variables.
ENV HOME="/home/vscode"
ENV UV_CACHE_DIR="/home/vscode/.uv_cache"

# Switch to non-root user and home directory.
USER vscode
WORKDIR /home/vscode

# Install and configure Golang
ARG GO_VERSION=go1.26.1.linux-amd64.tar.gz
ARG GO_VERSION_HASH=031f088e5d955bab8657ede27ad4e3bc5b7c1ba281f05f245bcc304f327c987a
RUN cd /home/vscode && curl -OL https://golang.org/dl/${GO_VERSION} && \
    echo "${GO_VERSION_HASH} *${GO_VERSION}" | sha256sum -c - && \
    tar -zxf ${GO_VERSION} && \
    rm ${GO_VERSION}

RUN mkdir -p /home/vscode/go-path
RUN mkdir -p /home/vscode/go
ENV GOPATH=/home/vscode/go-path
ENV GOROOT=/home/vscode/go
ENV PATH=${PATH}:/usr/local/bin:$GOROOT/bin:$GOPATH/bin:/home/vscode/.local/bin
ENV GOTOOLCHAIN=auto

# Install and configure Python
COPY --from=ghcr.io/astral-sh/uv:debian /usr/local/bin/uv /usr/local/bin
COPY --from=ghcr.io/astral-sh/uv:debian /usr/local/bin/uvx /usr/local/bin
ARG PYTHON_VERSION=3.13
RUN uv python install ${PYTHON_VERSION}
ENV UV_LINK_MODE=copy


# Install CLI tools
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d

# Install Go tools
RUN go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
RUN go install github.com/jstemmer/go-junit-report/v2@latest