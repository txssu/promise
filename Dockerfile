FROM ubuntu:latest

RUN apt-get update -y               \
    && apt-get -y install locales   \
    && apt-get clean                \
    && rm -f /var/lib/apt/lists/*_*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/app"
RUN chown nobody /app

# set runner ENV
ENV MIX_ENV="prod"

# Only copy the final release from the build stage
COPY _build/${MIX_ENV}/rel/promise ./

USER nobody

CMD ["/app/bin/server"]
