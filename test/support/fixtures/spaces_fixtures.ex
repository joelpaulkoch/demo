defmodule Demo.SpacesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Demo.Spaces` context.
  """

  @doc """
  Generate a space.
  """
  def space_fixture(attrs \\ %{}) do
    {:ok, space} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Demo.Spaces.create_space()

    space
  end
end
