defmodule DemoWeb.Schema do
  @moduledoc """
  The GraphQL schema definition
  """

  use Absinthe.Schema

  import_types(DemoWeb.Schema.SpaceTypes)

  alias DemoWeb.SpacesResolver

  query do
    @desc "Get all spaces"
    field :all_spaces, non_null(list_of(non_null(:space))) do
      resolve(&SpacesResolver.all_spaces/3)
    end

    @desc "Get a space"
    field :space, :space do
      arg(:name, non_null(:string))
      resolve(&SpacesResolver.find_space/3)
    end
  end

  mutation do
    @desc "Create a new space"
    field :create_space, :space do
      arg(:name, non_null(:string))

      resolve(&SpacesResolver.create_space/3)
    end
  end
end
