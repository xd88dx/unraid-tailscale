FROM alpine:latest AS build
RUN apk add --no-cache bash wget
WORKDIR /work
ARG VERSION
ENV VERSION=${VERSION}
COPY ./download.sh .
RUN ./download.sh

FROM alpine:latest AS deploy
RUN apk add --no-cache ca-certificates iptables iproute2
WORKDIR /app
COPY --from=build /work/latest /app
COPY docker-entrypoint.sh /app
ENTRYPOINT ["/app/docker-entrypoint.sh"]
