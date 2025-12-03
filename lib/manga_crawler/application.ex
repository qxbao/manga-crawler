defmodule MangaCrawler.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MangaCrawler.Repo,
      {Finch, name: MangaCrawler.HTTPClient},
    ]

    opts = [strategy: :one_for_one, name: MangaCrawler.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
