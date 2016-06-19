FROM sentry-base:latest


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

# This needs to be creaed!!!
ADD init_sentry_data.sh /conf/
RUN chmod +x /conf/init_sentry_data.sh

ADD sys/app/prepare_and_run_sentry.sh /conf/
RUN chmod +x /conf/prepare_and_run_sentry.sh

ADD sys/app/create_sentry_user.py /conf/create_sentry_user.py

ENTRYPOINT ["/conf/prepare_and_run_sentry.sh"]

EXPOSE $SENTRY_PORT

