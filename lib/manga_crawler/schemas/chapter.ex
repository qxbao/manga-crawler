defmodule MangaCrawler.Schemas.Chapter do
  use Ecto.Schema

  schema "chapters" do
    field :chapter_number, :float
    field :title, :string
    field :crawl_status, :string, default: "pending"

    belongs_to :series, MangaCrawler.Schemas.Series

    has_many :pages, MangaCrawler.Schemas.Page

    timestamps()
  end
end
