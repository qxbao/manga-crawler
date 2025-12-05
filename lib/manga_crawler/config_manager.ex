defmodule MangaCrawler.Config do
  @app :manga_crawler

  def get_all(), do: Application.get_env(@app, :crawler_settings)

  def get_supported_sources() do
    get_all() |> Hocon.get("Source.Supported")
  end

  def get_source_config(source_name) when is_binary(source_name) do
    get_all() |> Hocon.get("Source.Config.#{source_name}")
  end
end
