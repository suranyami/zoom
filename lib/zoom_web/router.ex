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
    analyze_complexity: true,
    interface: :playground
  )

  scope "/", ZoomWeb do
    pipe_through(:browser)
    get("/", PageController, :index)
    resources("/page", PageController)
  end
end
