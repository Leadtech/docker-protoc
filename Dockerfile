FROM docker:20.10.22 as static-docker-source

FROM debian:bullseye-slim

MAINTAINER Daan Biesterbos

ARG GIT_BRANCH=""
ARG GIT_REPO=''
ARG GIT_COMMIT=''

LABEL "repo"="$GIT_REPO" "branch"="$GIT_BRANCH" "commit"="$GIT_COMMIT"

COPY --from=static-docker-source /usr/local/bin/docker /usr/local/bin/docker

RUN mkdir -p /usr/share/man/man1/
RUN apt-get update -qqy && apt-get install -qqy \
        bash \
        curl \
        gcc \
        make \
        python3-dev \
        python3-pip \
        apt-transport-https \
        lsb-release \
        openssh-client \
        protobuf-compiler \
        git \
        gnupg && \
    pip3 install -U crcmod

ENTRYPOINT ["/bin/bash"]