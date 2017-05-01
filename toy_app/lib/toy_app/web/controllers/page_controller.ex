defmodule ToyApp.Web.PageController do
  use ToyApp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
