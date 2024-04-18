defmodule DemoWeb.SchemaTest do
  use DemoWeb.ConnCase

  import Demo.SpacesFixtures

  @space_query """
    query {
      allSpaces{
        id
        name
      }    
    }
  """

  test "query: allSpaces", %{conn: conn} do
    _space = space_fixture(%{name: "testspace"})

    conn =
      post(conn, "/api", %{
        "query" => @space_query
      })

    assert json_response(conn, 200) == %{
             "data" => %{"allSpaces" => [%{"id" => "1", "name" => "testspace"}]}
           }
  end
end
