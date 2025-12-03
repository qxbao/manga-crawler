defmodule MangaCrawler.Series do
  use Ecto.Schema

  schema "series" do
    field :title, :string
    field :slug, :string

    timestamps()
  end
end
