
FROM alpine:3.4

COPY etc /etc
COPY opt /opt

RUN \
    apk --no-cache add acserver && \
    true

ENTRYPOINT /opt/entry.sh
