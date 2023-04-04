FROM debian:bullseye-slim

MAINTAINER Daan Biesterbos

ARG PROTOC_VERSION="21.12"
ARG GIT_BRANCH=""
ARG GIT_REPO=''
ARG GIT_COMMIT=''
ENV PROTOC_VERSION=$PROTOC_VERSION

LABEL "repo"="$GIT_REPO" "branch"="$GIT_BRANCH" "commit"="$GIT_COMMIT"

RUN mkdir -p /usr/share/man/man1/
RUN apt-get update -qqy && apt-get install -qqy \
        bash \
        curl \
        wget \
        gcc \
        make \
        python3-dev \
        python3-pip \
        apt-transport-https \
        lsb-release \
        openssh-client \
        git \
        gnupg \
        autoconf automake libtool  g++ unzip && \
    pip3 install -U crcmod

RUN mkdir -p /opt/protoc
WORKDIR /opt/

RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip
RUN unzip protoc-${PROTOC_VERSION}-linux-x86_64.zip -d /opt/protoc
RUN rm protoc-${PROTOC_VERSION}-linux-x86_64.zip
ENV PATH="$PATH:/opt/protoc/bin/"

ENTRYPOINT ["/bin/bash"]
