FROM alpine:3.20 AS builder

RUN apk add --no-cache hugo

WORKDIR /workspace

COPY . .

RUN hugo --minify