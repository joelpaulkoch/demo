defmodule DemoWeb.SpacesResolver do
  @moduledoc """
    The GraphQL resolver for spaces
  """

  alias Demo.Spaces

  def all_spaces(_root, _args, _info) do
    {:ok, Spaces.list_spaces()}
  end

  def create_space(_root, args, _info) do
    case Spaces.create_space(args) do
      {:ok, space} -> {:ok, space}
      _error -> {:error, "could not create space"}
    end
  end

  def find_space(_root, args, _info) do
    case Spaces.find_space(args) do
      {:ok, space} -> {:ok, space}
      _error -> {:error, "could not find space"}
    end
  end
end
