
FROM alpine:3.4

COPY etc /etc
COPY opt /opt

ENV \
    SERVER_NAME=default \
    ACI_DIRECTORY=/var/aci/store \
    TEMPLATE_DIRECTORY=/var/aci/templates \
    USERNAME=default \
    PASSWORD=default \
    SERVER_PORT=80

RUN \
    apk update && \
    apk add acserver && \
    mkdir -p $ACI_DIRECTORY && \
    mkdir -p $TEMPLATE_DIRECTORY && \
    true

ENTRYPOINT /opt/entry.sh
