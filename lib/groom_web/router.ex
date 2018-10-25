defmodule ZoomWeb.Router do
  use ZoomWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ZoomWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  forward(
    "/graphql",
    Absinthe.Plug,
    schema: ZoomWeb.Schema
  )

  forward(
    "/graphiql",
    Absinthe.Plug.GraphiQL,
    schema: ZoomWeb.Schema,
    socket: ZoomWeb.UserSocket,
    interface: :advanced
  )
end
