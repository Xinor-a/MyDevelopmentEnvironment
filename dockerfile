FROM ubuntu:24.04

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        sudo

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN mkdir -p /tmp/scripts
COPY scripts /tmp/scripts
RUN chmod 777 /tmp/scripts/init.sh

COPY devenv /etc/devenv
RUN chmod 777 /etc/devenv/

RUN mkdir -p /var/log && chmod 777 /var/log
RUN /tmp/scripts/init.sh 2>&1 | tee /var/log/init.log

CMD ["/bin/bash"]