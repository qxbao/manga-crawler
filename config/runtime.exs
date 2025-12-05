env = Dotenv.load()

import Config

if config_env() in [:dev, :test, :prod] do
  # Load .env
  Dotenv.load()

  # Load HOCON
  hocon_path = Path.expand("../config.conf", __DIR__)

  if File.exists?(hocon_path) do
    case Hocon.decode(File.read!(hocon_path)) do
      {:ok, hocon_config} ->
        config :manga_crawler,
          crawler_settings: hocon_config

      {:error, reason} ->
        IO.puts("HOCON Parse Error: #{inspect(reason)}")
        raise "Failed to parse HOCON configuration file."
    end
  end

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
end
