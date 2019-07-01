from gocd/gocd-agent-alpine-3.9:v19.5.0

run \
    apk --no-cache upgrade \
    apk add --no-cache git
