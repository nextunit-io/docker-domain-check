# docker-domain-check

Docker Image to check domains and send out notification to an Slack Endpoint.

It will check every given domain if that domaini is availble and free.

## Build

To build the image on your own, use:

```bash
docker build -t nextunit/domain-check .
```

## Required environment variables

|Variable|Description|
|--|--|
|DOMAINS_TO_CHECK|A list of domains that should be checked.|
|SLACK_NOTIFICATION_ENDPOINT *(Optional)*|This entry is just required, if you'd like to send update-debug messages to slack.|

## Run Docker

There are two ways to set environment variables. You can find examples for both below.

### Without environment file

```bash
docker run  -e DOMAINS_TO_CHECK="<list of domain>" -e "SLACK_NOTIFICATION_ENDPOINT=<slack>" --rm nextunit/domain-check
```
