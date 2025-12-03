defmodule MangaCrawler.Schemas.Page do
  use Ecto.Schema

  schema "pages" do
    field :page_number, :integer
    field :image_url, :string

    belongs_to :chapter, MangaCrawler.Schemas.Chapter

    timestamps()
  end
end
