FROM elixir:1.14-alpine

# prepare build dir
WORKDIR /app

RUN apk add --no-cache make gcc libc-dev

COPY mix.exs mix.lock ./

COPY priv priv
COPY config config
COPY lib lib

RUN mix local.hex --force && mix local.rebar --force

ENV IN_DOCKER=true

RUN mix deps.get
RUN mix compile

COPY scripts/docker_startup.sh .

ENTRYPOINT ["./docker_startup.sh"]
