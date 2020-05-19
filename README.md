# logzio-postgresql-logs

[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/alarconj/postgresql-logs)](https://hub.docker.com/r/alarconj/postgresql-logs)

=========================

It will check every 60 seconds the log file. You can define a different value.

[Docker hub repository](https://hub.docker.com/r/alarconj/postgresql-logs/)

This container ships your PostgreSQL logs to logz.io.
It ships its logs and PostgreSQL logs automatically to Logz.io via SSL so everything is encrypted.

***

## Usage (docker run)

```bash
docker run -d \
  --name logzio-postgresql-logs \
  -e LOGZIO_TOKEN=VALUE \
  [-e LOGZIO_LISTENER=VALUE] \
  [-e POSTGRESQL_LOG_FILE=VALUE] \
  -v path_to_directory:/var/log/logzio \
  -v path_to_directory:/var/log/postgresql \
  alarconj/postgresql-logs:latest
```

### Mandatory for Usage

**LOGZIO_TOKEN** - Your [Logz.io App](https://app.logz.io) token, where you can find under "settings" in the web app.

#### Optional for Usage

**POSTGRESQL_LOG_FILE** - Path to PostgreSQL general log. Default: /var/log/postgresql/postgresql.log

**LOGZIO_LISTENER** - Logzio listener host name. Default: listener.logz.io

### Example

```bash
docker run -d \
  --name logzio-postgresql-logs \
  -e LOGZIO_TOKEN="YOUR_TOKEN" \
  -v /path/to/directory/logzio:/var/log/logzio \
  -v /path/to/directory/postgresql:/var/log/postgresql \
  --restart=always \
  alarconj/postgresql-logs:latest
```

***

## RDS Usage (docker run)

```bash
docker run -d --restart \
  --name logzio-postgresql-logs -e LOGZIO_TOKEN=VALUE [-e LOGZIO_LISTENER=VALUE] \
  -e AWS_ACCESS_KEY=VALUE \
  -e AWS_SECRET_KEY=VALUE \
  -e RDS_IDENTIFIER=VALUE \
  [-e AWS_REGION=VALUE] \
  [-e RDS_LOG_FILE=VALUE] \
  [-e AWS_ACCOUNT=VALUE] \
  [-e CLIENT_LF=VALUE] \
  [-e ENVIRONMENT_LF=VALUE] \
  alarconj/postgresql-logs:latest
```

### Mandatory

**LOGZIO_TOKEN** - Your [Logz.io App](https://app.logz.io) token, where you can find under "settings" in the web app.

**AWS_ACCESS_KEY** - A proper AMI credentials for RDS logs access (permissions for `download-db-log-file-portion` and `describe-db-log-files` are needed)

**AWS_SECRET_KEY** - A proper AMI credentials for RDS logs access (permissions for `download-db-log-file-portion` and `describe-db-log-files` are needed)

**RDS_IDENTIFIER** - The RDS identifier of the host from which you want to read logs from.

### Optional

**RDS_LOG_FILE** - The path to the RDS general log file. Default: general/postgresql-general.log

**LOGZIO_LISTENER** - Logzio/Logstash listener host name. Default: listener.logz.io

**INTERVAL_SECONDS** - RDS Sync interval. Default: 60 seconds

**AWS_REGION** - Default: us-east-1

**AWS_ACCOUNT** - Name of AWS Account. You can remove it if you wish.

**CLIENT_LF** - Name of client. You can remove it if you wish.

**ENVIRONMENT_LF** - Name of Environmetn (prod, dev, uat) . You can remove it if you wish.

### RDS Example

```bash
docker run -d --restart \
  --name logzio-postgresql-logs \
  -e LOGZIO_TOKEN="YOUR_TOKEN" \
  -e AWS_ACCESS_KEY="YOUR_ACCESS_KEY" \
  -e AWS_SECRET_KEY="YOUR_SECRET_KEY" \
  -e AWS_REGION="YOUR_REGION" \
  -e RDS_IDENTIFIER="YOUR_DB_IDENTIFIER" \
  -e RDS_LOG_FILE=error/postgresql.log \
  -e AWS_ACCOUNT="NAME_AWS_ACCOUNT" \
  -e CLIENT_LF="NAME_OF_CLIENT" \
  -e ENVIRONMENT_LF="NAME_OF_ENVIRONMENT" \
  -e INTERVAL_SECONDS="SECONDS"
  alarconj/postgresql-logs:latest
```

***

## Screenshots of dashboard from Logz.io

![alt text](https://images.contentful.com/50k90z6lk1k7/5M1Ayh1HxYuiY8soCgCCMc/fcaf1eb5fa28f98ec24a26fe96b222ac/mysql_monitor_dash.png?h=250& "Logz.io Dashboard")

***

## About Logz.io

[Logz.io](https://logz.io) combines open source log analytics and behavioural learning intelligence to pinpoint what’s actually important

***

## Credits

Based on original work from Logz.io people to ship [from MySQL to Logzio](https://github.com/logzio/logzio-mysql-logs) and in [Sebastian Martinka's branch](https://github.com/Mortinke/logzio-mysql-logs/tree/postgres-support).
