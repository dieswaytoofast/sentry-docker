FROM python:2.7

### COMMON FOR ALL CONTAINERS

# DB
ARG SENTRY_DB_PORT
ENV SENTRY_DB_PORT $SENTRY_DB_PORT
# REDIS
ARG SENTRY_REDIS_PORT
ENV SENTRY_REDIS_PORT $SENTRY_REDIS_PORT
# SENTRY
ARG SENTRY_PORT
ENV SENTRY_PORT $SENTRY_PORT
# NGINX
ARG SENTRY_NGINX_PORT_HTTP
ARG SENTRY_NGINX_PORT_HTTPS
ENV SENTRY_NGINX_PORT_HTTP $SENTRY_NGINX_PORT_HTTP
ENV SENTRY_NGINX_PORT_HTTPS $SENTRY_NGINX_PORT_HTTPS

### END COMMON FOR ALL CONTAINERS ###

MAINTAINER Mahesh Paolini-Subramanya <mahesh@dieswaytoofast.com> via Sławek Ehlert <slafs@op.pl>

RUN pip install -U wheel pip setuptools

RUN apt-get -qq update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
    libxslt1-dev \
    libxml2-dev \
    libpq-dev \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev

RUN mkdir -p /conf /data /wheels

ADD sys/base/requirements.txt /conf/

RUN pip wheel --wheel-dir=/wheels -r /conf/requirements.txt \
    && pip install --find-links=/wheels -r /conf/requirements.txt

ADD sys/base/sentry_docker_conf.py /conf/
ADD sys/base/sentry_run /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/sentry_run"]

CMD ["start"]

ADD sys/base/scripts/create_team_or_project.py /conf/
ADD sys/base/scripts/check_db_isalive.py /conf/

# some cleanup
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /wheels/*

