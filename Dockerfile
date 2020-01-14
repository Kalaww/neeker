FROM elixir:1.9-alpine AS builder

ENV LANG en_US.UTF-8
ENV MIX_ENV prod

WORKDIR /usr/src/app
COPY . $PWD

RUN set -x \
 && apk update && apk upgrade && apk add git curl make g++ \
 && mix do local.hex --force, local.rebar --force, deps.get --only prod \
 && mix release \
 && mkdir -p /opt/rel \
 && mv /usr/src/app/_build/prod/rel/neeker/* /opt/rel

#####################################################################
FROM alpine:3.9

ENV LANG en_US.UTF-8

WORKDIR /app
COPY --from=builder /opt/rel $PWD

RUN set -x \
 && apk update && apk upgrade && apk add openssl-dev ncurses bash \
 && rm -r /var/cache/apk/* \
 && ln -s /app/bin/neeker /app/bin/rel

ENTRYPOINT ["/app/bin/rel"]
CMD ["start"]
