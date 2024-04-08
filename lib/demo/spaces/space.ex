defmodule Demo.Spaces.Space do
  @moduledoc """
  The space resource.
  Every space shows something magical to the user.
  Users can restrict access to spaces and share them
  with other users.  
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "spaces" do
    field :name, :string
    field :image, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(space, attrs) do
    space
    |> cast(attrs, [:name, :image])
    |> validate_required([:name])
    |> validate_format(:name, ~r/^[^\s]+$/)
    |> unique_constraint([:name])
  end
end
