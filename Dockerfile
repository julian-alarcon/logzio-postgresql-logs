FROM ubuntu:20.04

LABEL maintainer="alarconj@gmail.com" \
      version="1.0" \
      description="Container to export PostgreSQL/RDS PostgreSQL logs to Logzio/Logstash"

ENV LOGZIO_LOGS_DIR /var/log/logzio
ENV POSTGRESQL_LOGS_DIR /var/log/postgresql
ENV JAVA_HOME /usr/
ENV AWS_CREDENTIAL_FILE /root/.aws/credentials
ENV FILEBEAT_CONF /etc/filebeat/filebeat.yml
ENV POSTGRESQL_LOG_FILE ""

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    python3-pip \
    bc \
    curl \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install awscli

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.2-amd64.deb && dpkg -i filebeat-7.6.2-amd64.deb
RUN mkdir -p /etc/pki/tls/certs
RUN wget https://raw.githubusercontent.com/logzio/public-certificates/master/COMODORSADomainValidationSecureServerCA.crt -P /etc/pki/tls/certs

RUN mkdir -p $POSTGRESQL_LOGS_DIR
RUN mkdir -p $LOGZIO_LOGS_DIR

ADD scripts/go.bash /root/
ADD scripts/utils.sh /root/
ADD scripts/base.sh /root/
ADD files/filebeat.yml $FILEBEAT_CONF
ADD files/filebeat-rds.yml /root/

WORKDIR /root
CMD ["/root/go.bash"]
