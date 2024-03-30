defmodule DemoWeb.SpaceLiveTest do
  use DemoWeb.ConnCase

  import Phoenix.LiveViewTest
  import Demo.SpacesFixtures

  @create_attrs %{name: "some name"}
  @invalid_attrs %{name: nil}

  defp create_space(_) do
    space = space_fixture()
    %{space: space}
  end

  describe "Index" do
    setup [:create_space]

    test "lists all spaces", %{conn: conn, space: space} do
      {:ok, _index_live, html} = live(conn, ~p"/spaces")

      assert html =~ "Listing Spaces"
      assert html =~ space.name
    end

    test "saves new space", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/spaces")

      assert index_live |> element("a", "New Space") |> render_click() =~
               "New Space"

      assert_patch(index_live, ~p"/spaces/new")

      assert index_live
             |> form("#space-form", space: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#space-form", space: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/spaces")

      html = render(index_live)
      assert html =~ "Space created successfully"
      assert html =~ "some name"
    end

    test "deletes space in listing", %{conn: conn, space: space} do
      {:ok, index_live, _html} = live(conn, ~p"/spaces")

      assert index_live |> element("#spaces-#{space.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#spaces-#{space.id}")
    end
  end

  describe "Show" do
    setup [:create_space]

    test "displays space", %{conn: conn, space: space} do
      {:ok, _show_live, html} = live(conn, ~p"/spaces/#{space.name}")

      assert html =~ space.name
    end

    test "has some magic", %{conn: conn, space: space} do
      {:ok, _show_live, html} = live(conn, ~p"/spaces/#{space.name}")

      assert html =~ space.name
    end
  end
end
