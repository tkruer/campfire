FROM ubuntu:20.04

ARG DEFAULT_TZ=America/Los_Angeles
ENV DEFAULT_TZ=$DEFAULT_TZ

RUN apt-get update \
   && DEBIAN_FRONTEND=noninteractive TZ=$DEFAULT_TZ apt-get install -y \
   tzdata \
   vim \
   nano \
   sudo \
   curl \
   wget \
   git && \
   rm -rf /var/lib/apt/lists/*


ARG AUTH_KEY=mut_67a47e3e8aeb45f6b12063ba19b042d7
ENV AUTH_KEY=$AUTH_KEY

RUN curl https://get.modular.com | sh - && \
    modular auth $AUTH_KEY 
RUN modular install mojo

RUN mojo main.mojo
