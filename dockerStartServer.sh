#!/bin/sh

XMAGE_CONFIG="/xmage/mage-server/config/config.xml"

sed -i -e "
    s#\(serverAddress=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_SERVER_ADDRESS}\"#g;
    s#\(mailgunApiKey=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_MAILGUN_API_KEY}\"#g;
    s#\(mailgunDomain=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_MAILGUN_DOMAIN}\"#g;
    s#\(mailSmtpHost=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_MAIL_SMTP_HOST}\"#g;
    s#\(mailSmtpPort=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_MAIL_SMTP_PORT}\"#g;
    s#\(mailUser=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_MAIL_USER}\"#g;
    s#\(mailPassword=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_MAIL_PASSWORD}\"#g;
    s#\(mailFromAddress=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_MAIL_FROM_ADDRESS}\"#g;
    s#\(serverName=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_SERVER_NAME}\"#g;
    s#\(port=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_PORT}\"#g;
    s#\(secondaryBindPort=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_SEONDARY_BIND_PORT}\"#g;
    s#\(maxSecondsIdle=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_MAX_SECONDS_IDLE}\"#g;
    s#\(maxGameThreads=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_MAX_GAME_THREADS}\"#g;
    s#\(maxAiOpponents=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_MAX_AI_OPPONENTS}\"#g;
    s#\(backlogSize=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_BACKLOGSIZE}\"#g;
    s#\(numAcceptThreads=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_ACCEPTTHREADS}\"#g;
    s#\(maxPoolSize=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_POOLSIZE}\"#g;
    s#\(leasePeriod=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_LEASEPERIOD}\"#g;
    s#\(authenticationActivated=\)[\"].*[\"]#\1\"${XMAGE_DOCKER_AUTHENTICATION_ACTIVATED}\"#g
" \
"${XMAGE_CONFIG}"

if [[ -z "$XMAGE_DOCKER_SERVER_ADMIN_PASSWORD" ]]; then
    # No Password Set
    java $XMAGE_DOCKER_JAVA_OPTS -jar ./lib/mage-server-*.jar
else
    # Password Set
    java $XMAGE_DOCKER_JAVA_OPTS -jar ./lib/mage-server-*.jar -adminPassword=$XMAGE_DOCKER_SERVER_ADMIN_PASSWORD
fi
