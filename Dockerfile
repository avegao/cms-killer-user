FROM golang:1.8.3-alpine AS build-env

RUN mkdir -p /go/src/github.com/avegao/cms-killer-user

WORKDIR /go/src/github.com/avegao/cms-killer-user

RUN apk add --no-cache git glide

COPY glide.yaml glide.yaml
COPY glide.lock glide.lock

RUN glide install

COPY . .

RUN env && ls -lah && go install

########################################################################################################################

FROM alpine:3.5
WORKDIR /app
COPY --from=build-env /go/bin/cms-killer-user /app/cms-killer-user

EXPOSE 50000

LABEL maintainer="Álvaro de la Vega Olmedilla <alvarodlvo@gmail.com>"

ENTRYPOINT ["./cms-killer-user"]
