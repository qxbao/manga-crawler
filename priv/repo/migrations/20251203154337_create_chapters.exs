defmodule MangaCrawler.Repo.Migrations.CreateChapters do
  use Ecto.Migration

  def change do
    create table(:chapters) do
      add :chapter_number, :float, null: false
      add :title, :string
      add :crawl_status, :string, default: "pending" # pending, completed, error

      add :series_id, references(:series, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:chapters, [:series_id])
    create unique_index(:chapters, [:series_id, :chapter_number])
  end
end
