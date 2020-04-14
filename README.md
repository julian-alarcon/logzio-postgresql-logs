# logzio-mysql-logs

=========================

[Docker hub repository](https://hub.docker.com/r/logzio/mysql-logs/)

This container ships your mysql logs to logz.io.
It ships its logs and MySQL logs automatically to Logz.io via SSL so everything is encrypted.

***

## Usage (docker run)

```bash
docker run -d --name logzio-mysql-logs -e LOGZIO_TOKEN=VALUE [-e LOGZIO_LISTENER=VALUE] \
          [-e MYSQL_ERROR_LOG_FILE=VALUE] [-e MYSQL_SLOW_LOG_FILE=VALUE] [-e MYSQL_LOG_FILE=VALUE] \
          -v path_to_directory:/var/log/logzio -v path_to_directory:/var/log/mysql \
          logzio/mysql-logs:latest
```

### Mandatory for Usage

**LOGZIO_TOKEN** - Your [Logz.io App](https://app.logz.io) token, where you can find under "settings" in the web app.

#### Optional for Usage

**MYSQL_ERROR_LOG_FILE** - Path to mysql error log. Default: /var/log/mysql/error.log

**MYSQL_SLOW_LOG_FILE** - Path to mysql slow query log. Default: /var/log/mysql/mysql-slow.log

**MYSQL_LOG_FILE** - Path to mysql general log. Default: /var/log/mysql/mysql.log

**LOGZIO_LISTENER** - Logzio listener host name. Default: listener.logz.io

### Example

```bash
docker run -d \
  --name logzio-mysql-logs \
  -e LOGZIO_TOKEN="YOUR_TOKEN" \
  -v /path/to/directory/logzio:/var/log/logzio \
  -v /path/to/directory/mysql:/var/log/mysql \
  --restart=always \
  logzio/mysql-logs:latest
```

***

## RDS Usage (docker run)

```bash
docker run -d --name logzio-mysql-logs -e LOGZIO_TOKEN=VALUE [-e LOGZIO_LISTENER=VALUE] \
          -e AWS_ACCESS_KEY=VALUE -e AWS_SECRET_KEY=VALUE -e RDS_IDENTIFIER=VALUE [-e AWS_REGION=VALUE] \
          [-e RDS_ERROR_LOG_FILE=VALUE] [-e RDS_SLOW_LOG_FILE=VALUE] [-e RDS_LOG_FILE=VALUE] \
          -v path_to_directory:/var/log/logzio -v path_to_directory:/var/log/mysql \
          logzio/mysql-logs:latest
```

### Mandatory

**LOGZIO_TOKEN** - Your [Logz.io App](https://app.logz.io) token, where you can find under "settings" in the web app.

**AWS_ACCESS_KEY** - A proper AMI credentials for RDS logs access (permissions for `download-db-log-file-portion` and `describe-db-log-files` are needed)

**AWS_SECRET_KEY** - A proper AMI credentials for RDS logs access (permissions for `download-db-log-file-portion` and `describe-db-log-files` are needed)

**RDS_IDENTIFIER** - The RDS identifier of the host from which you want to read logs from.

### Optional

**RDS_ERROR_LOG_FILE** - The path to the RDS error log file. Default: error/mysql-error.log

**RDS_SLOW_LOG_FILE** - The path to the RDS slow query log file. Default: slowquery/mysql-slowquery.log

**RDS_LOG_FILE** - The path to the RDS general log file. Default: general/mysql-general.log

**LOGZIO_LISTENER** - Logzio listener host name. Default: listener.logz.io

**INTERVAL_SECONDS** - RDS Sync interval. Default: 60 seconds

**AWS_REGION** - Default: us-east-1

### RDS Example

```bash
docker run -d \
  --name logzio-mysql-logs \
  -e LOGZIO_TOKEN="YOUR_TOKEN" \
  -e AWS_ACCESS_KEY="YOUR_ACCESS_KEY" \
  -e AWS_SECRET_KEY="YOUR_SECRET_KEY" \
  -e AWS_REGION="YOUR_REGION" \
  -e RDS_IDENTIFIER="YOUR_DB_IDENTIFIER" \
  -e RDS_ERROR_LOG_FILE=error/mysql-error.log \
  -e RDS_SLOW_LOG_FILE=slowquery/mysql-slowquery.log \
  -e RDS_LOG_FILE=general/mysql-general.log \
  -v /var/log/logzio:/var/log/logzio \
  -v /var/log/mysql:/var/log/mysql \
  logzio/mysql-logs:latest
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
