defmodule DemoWeb.HomeLiveTest do
  use DemoWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Index" do
    test "shows the magic demo landing page", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/")

      assert html =~ "magic demo"
    end

    # test "lists all spaces", %{conn: conn} do
    # end

    test "creates and redirects to new space", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/")

      {:ok, space_live, _html} =
        index_live |> element("button", "Let's go") |> render_click() |> follow_redirect(conn)

      assert render(space_live) =~ "Space"
    end
  end
end
