FROM eclipse-temurin:21-jre-alpine

# Set XMage config defaults
ENV LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    XMAGE_DOCKER_SERVER_ADDRESS="0.0.0.0" \
    XMAGE_DOCKER_PORT="17171" \
    XMAGE_DOCKER_SEONDARY_BIND_PORT="17179" \
    XMAGE_DOCKER_MAX_SECONDS_IDLE="300" \
    XMAGE_DOCKER_AUTHENTICATION_ACTIVATED="false" \
    XMAGE_DOCKER_SERVER_NAME="mage-server" \
    XMAGE_DOCKER_SERVER_ADMIN_PASSWORD="" \
    XMAGE_DOCKER_MAILGUN_API_KEY="" \
    XMAGE_DOCKER_MAILGUN_DOMAIN="" \
    XMAGE_DOCKER_MAIL_SMTP_HOST="" \
    XMAGE_DOCKER_MAIL_SMTP_PORT="" \
    XMAGE_DOCKER_MAIL_USER="" \
    XMAGE_DOCKER_MAIL_PASSWORD="" \
    XMAGE_DOCKER_MAIL_FROM_ADDRESS="" \
    XMAGE_DOCKER_MAX_GAME_THREADS="10" \
    XMAGE_DOCKER_MAX_AI_OPPONENTS="15" \
    XMAGE_DOCKER_BACKLOGSIZE="200" \
    XMAGE_DOCKER_ACCEPTTHREADS="2" \
    XMAGE_DOCKER_POOLSIZE="300" \
    XMAGE_DOCKER_LEASEPERIOD="5000" \
    XMAGE_DOCKER_JAVA_OPTS="-Xmx1024m -XX:MaxPermSize=384m -Dlog4j.configuration=file:./config/log4j.properties"

# Install dependencies and xmage
WORKDIR /xmage

RUN set -ex \
    && apk upgrade \
    && apk add curl ca-certificates bash jq \
    && curl --silent --show-error https://grath.github.io/config.json | jq '.XMage.location' | xargs curl -# -L > xmage.zip \
    && unzip xmage.zip -x "mage-client*" \
    && rm xmage.zip \
    && apk del curl jq \
    && rm -rf /var/cache/apk/*

COPY dockerStartServer.sh /xmage/mage-server/

RUN chmod +x \
    /xmage/mage-server/startServer.sh \
    /xmage/mage-server/dockerStartServer.sh

EXPOSE 17171 17179

WORKDIR /xmage/mage-server

CMD [ "./dockerStartServer.sh" ]
