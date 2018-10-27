defmodule ZoomWeb.PageController do
  use ZoomWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
