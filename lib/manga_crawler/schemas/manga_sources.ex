defmodule MangaCrawler.Schemas.MangaSource do
  use Ecto.Schema

  schema "manga_sources" do
    field :name, :string
    field :base_url, :string
    field :is_active, :boolean, default: true

    has_many :series, MangaCrawler.Schemas.Series

    timestamps()
  end
end
