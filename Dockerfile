FROM golang:1.14-alpine AS build

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

WORKDIR /app
ADD greeter_server /app/greeter_server
ADD helloworld /app/helloworld
ADD go.mod .

RUN go mod download

RUN go build -o /go/bin/greeter_server /app/greeter_server/main.go

FROM alpine

COPY --from=build /go/bin/greeter_server /bin/greeter_server
