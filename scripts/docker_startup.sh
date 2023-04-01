#!/usr/bin/env sh

mix ecto.setup
mix run priv/repo/seeds.exs
mix phx.server
