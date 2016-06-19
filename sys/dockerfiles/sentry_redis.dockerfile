FROM redis:3.2-alpine

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


ADD sys/redis/redis.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

EXPOSE $SENTRY_REDIS_PORT