env = Dotenv.load()

import Config

config :manga_crawler,
  ecto_repos: [MangaCrawler.Repo]

config :manga_crawler, MangaCrawler.Repo,
  database: Dotenv.Env.get(env, "POSTGRE_DBNAME"),
  username: Dotenv.Env.get(env, "POSTGRE_USER"),
  password: Dotenv.Env.get(env, "POSTGRE_PASSWORD"),
  hostname: Dotenv.Env.get(env, "POSTGRE_HOSTNAME"),
  port: Dotenv.Env.get(env, "POSTGRE_PORT"),
  adapter: Ecto.Adapters.Postgres,
  show_sensitive_data_on_connection_error: true
