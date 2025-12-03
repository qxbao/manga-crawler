defmodule MangaCrawler.Repo.Migrations.CreateSeries do
  use Ecto.Migration

  def change do
    create table(:series) do
      add :title, :string, null: false
      add :slug, :string, null: false
      add :description, :text

      add :manga_source_id, references(:manga_sources, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:series, [:manga_source_id])
    create unique_index(:series, [:title])
    create unique_index(:series, [:manga_source_id, :slug])
  end
end
