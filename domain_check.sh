#!/bin/bash

if [ -z "$DOMAINS_TO_CHECK" ]; then
    echo "No domains to check available."
    exit 1
fi

if [ -z "$SLACK_NOTIFICATION_ENDPOINT" ]; then
    echo "No notification endpoint available."
    exit 1
fi

AVAILABLE_DOMAINS=""

for domain in $DOMAINS_TO_CHECK; do
    host_not_found="$(host "$domain" 8.8.8.8 | grep "not found" | wc -l)"
    if [ "$host_not_found" -gt "0" ]; then
        if [ -n "$AVAILABLE_DOMAINS" ]; then
            AVAILABLE_DOMAINS="${AVAILABLE_DOMAINS}, "
        fi

        AVAILABLE_DOMAINS="${AVAILABLE_DOMAINS}$domain"
    fi
done

if [ -n "$AVAILABLE_DOMAINS" ]; then
    echo "Notification will be sent. $AVAILABLE_DOMAINS"
    curl -s -X POST -H 'Content-type: application/json' --data "{\"text\":\"Domain notification - The following domains are available: $AVAILABLE_DOMAINS\"}" $SLACK_NOTIFICATION_ENDPOINT > /dev/null
fi