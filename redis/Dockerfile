FROM redis:8.2.0

# Install envsubst (from gettext-base)
RUN apt-get update && apt-get install -y gettext-base && rm -rf /var/lib/apt/lists/*

# Copy config template
COPY redis.conf /usr/local/etc/redis/redis.conf.template

# Entry script will substitute env vars -> redis.conf
ENTRYPOINT [ "sh", "-c", "envsubst < /usr/local/etc/redis/redis.conf.template > /usr/local/etc/redis/redis.conf && exec redis-server /usr/local/etc/redis/redis.conf" ]
