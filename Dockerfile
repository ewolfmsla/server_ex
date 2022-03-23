FROM elixir:latest

WORKDIR /app

EXPOSE 8080

COPY . /app

RUN mix local.hex --force \
 && mix local.rebar --force

RUN MIX_ENV=prod mix do deps.get, compile, release

ENTRYPOINT ["/app/_build/prod/rel/server_ex/bin/server_ex"]
CMD ["start", "foreground"]