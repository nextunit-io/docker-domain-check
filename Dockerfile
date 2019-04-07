FROM alpine:latest

LABEL zero <zero@nextunit.io>

RUN \ 
    apk update && \
    apk add --update curl bash bind-tools

RUN adduser -S worker
RUN mkdir -p /home/worker

ENV SLACK_NOTIFICATION_ENDPOINT=""
ENV DOMAINS_TO_CHECK=""

WORKDIR /home/worker
COPY domain_check.sh /home/worker/domain_check.sh
RUN chown worker /home/worker/domain_check.sh

USER worker

ENTRYPOINT /bin/bash domain_check.sh
