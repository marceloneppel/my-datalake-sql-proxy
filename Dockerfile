FROM google/cloud-sdk:alpine

WORKDIR /auth

COPY proxy_auth.sh /auth/

COPY cloud_sql_proxy /bin

RUN apk update && apk add postgresql-client

CMD echo "keep container running" && tail -f /dev/null
