
FROM alpine:3.4

COPY etc /etc
COPY opt /opt

RUN \
    apk --no-cache add busybox-initscripts && \
    true

ENTRYPOINT /opt/entry.sh
