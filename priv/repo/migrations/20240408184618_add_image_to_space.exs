defmodule Demo.Repo.Migrations.AddImageToSpace do
  use Ecto.Migration

  def change do
    alter table("spaces") do
      add :image, :string
    end
  end
end
