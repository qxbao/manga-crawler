import Config

config :manga_crawler,
  ecto_repos: [MangaCrawler.Repo]

config :finch,
  # Khai báo một Finch Pool (đặt tên là :default)
  pools: %{
    :default => [
      pool_size: 20,
      recv_timeout: 10_000,
      rate_limit: [
        rate: 5,
        period: 1000
      ]
    ]
  }
