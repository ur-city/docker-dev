FROM ubuntu:18.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y git 

RUN cd /tmp;\
    git clone https://github.com/ur-city/docker-dev.git docker --depth=1;\
    bash /tmp/docker/install.sh;\
    rm -rf /tmp/docker

USER root
ENTRYPOINT ["/etc/rc.local"]
