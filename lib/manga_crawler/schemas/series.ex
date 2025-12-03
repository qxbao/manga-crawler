defmodule MangaCrawler.Schemas.Series do
  use Ecto.Schema

  schema "series" do
    field :title, :string
    field :slug, :string
    belongs_to :manga_source, MangaCrawler.Schemas.MangaSource

    has_many :chapters, MangaCrawler.Schemas.Chapter

    timestamps()
  end
end
