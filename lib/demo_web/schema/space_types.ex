defmodule DemoWeb.Schema.SpaceTypes do
  @moduledoc """
    The GraphQL schema for spaces
  """

  use Absinthe.Schema.Notation

  object :space do
    field :id, :id
    field :name, :string
  end
end
