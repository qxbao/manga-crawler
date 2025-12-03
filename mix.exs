defmodule MangaCrawler.MixProject do
  use Mix.Project

  def project do
    [
      app: :manga_crawler,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      applications: applications()
    ]
  end

  def application do
    [
      mod: {MangaCrawler.Application, []},
      extra_applications: [:logger],
    ]
  end

  defp applications do
    [
      {:dotenv, :runtime_application}
    ]
  end

  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      {:plug_cowboy, "~> 2.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, "~> 0.16"},
      {:finch, "~> 0.16"},
      {:floki, "~> 0.33"},
      {:dotenv, "~> 3.1", runtime: false}
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
