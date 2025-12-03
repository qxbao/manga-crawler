defmodule MangaCrawler.Repo do
  use Ecto.Repo,
    otp_app: :manga_crawler,
    adapter: Ecto.Adapters.Postgres
end
