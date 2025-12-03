defmodule MangaCrawler.Repo.Migrations.CreateMangaSources do
  use Ecto.Migration

  def change do
    create table(:manga_sources) do
      add :name, :string, null: false
      add :base_url, :string, null: false
      add :is_active, :boolean, default: true

      timestamps()
    end

    create unique_index(:manga_sources, [:base_url])
  end
end
