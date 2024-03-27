defmodule Demo.Repo.Migrations.CreateSpaces do
  use Ecto.Migration

  def change do
    create table(:spaces) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
