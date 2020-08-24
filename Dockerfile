FROM google/cloud-sdk:alpine

WORKDIR /auth

COPY proxy_auth.sh /auth/

#COPY cloud_sql_proxy /bin


RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy && \
    chmod +x cloud_sql_proxy && \
    mv cloud_sql_proxy /bin/

RUN apk update && apk add postgresql-client

CMD echo "keep container running" && tail -f /dev/null
