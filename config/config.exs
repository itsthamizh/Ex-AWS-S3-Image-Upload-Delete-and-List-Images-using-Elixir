# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config


config :image,
  ecto_repos: [Image.Repo]

# Configures the endpoint
config :image, ImageWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ERM66wSRK0B0P6inDS92/saKfKszi0FxLPPGEulMsd7sXMoX/3sJdrNKFuXe5c/+",
  render_errors: [view: ImageWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Image.PubSub,
  live_view: [signing_salt: "/oB9Zsu2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
