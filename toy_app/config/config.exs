# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :toy_app,
  ecto_repos: [ToyApp.Repo]

# Configures the endpoint
config :toy_app, ToyApp.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FYocdDSEfAfD+SiGDZrCFfnhNuAqK3ggS6VPC2AmwD1+uo+imKvKo3JK41EKMX3h",
  render_errors: [view: ToyApp.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ToyApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures scrivener package
config :scrivener_html,
  routes_helper: ToyApp.Web.Router.Helpers,
  view_style: :bootstrap

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
