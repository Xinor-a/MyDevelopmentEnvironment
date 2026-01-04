FROM ubuntu:24.04

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        sudo

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN mkdir -p /tmp/config
COPY config /tmp/config
RUN chmod +x /tmp/config/init.sh
RUN mkdir -p /var/log && chmod 777 /var/log
RUN /tmp/config/init.sh 2>&1 | tee /var/log/init.log

CMD ["/bin/bash"]