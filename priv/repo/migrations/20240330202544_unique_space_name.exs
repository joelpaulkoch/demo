defmodule Demo.Repo.Migrations.UniqueSpaceName do
  use Ecto.Migration

  def change do
    create unique_index(:spaces, [:name])
  end
end
