use Mix.Config

config :zoom, ZoomWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--watch",
      "--colors",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

config :zoom, ZoomWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/zoom_web/views/.*(ex)$},
      ~r{lib/zoom_web/templates/.*(eex)$}
    ]
  ]

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :zoom, Zoom.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "zoom_dev",
  hostname: "localhost",
  pool_size: 10
