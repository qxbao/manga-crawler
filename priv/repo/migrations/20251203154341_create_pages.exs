defmodule MangaCrawler.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :page_number, :integer, null: false
      add :image_url, :string, null: false

      add :chapter_id, references(:chapters, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:pages, [:chapter_id])
    create unique_index(:pages, [:chapter_id, :page_number])
  end
end
