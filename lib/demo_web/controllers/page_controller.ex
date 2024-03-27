defmodule DemoWeb.PageController do
  use DemoWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def terms_of_service(conn, _params) do
    render(conn, :terms_of_service)
  end

  def privacy(conn, _params) do
    render(conn, :privacy)
  end
end
