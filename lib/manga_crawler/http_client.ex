defmodule MangaCrawler.HTTPClient do
  def get_html(url) do
    request = Finch.build(:get, url)

    case Finch.request(request, MangaCrawler.HTTPClient) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, body}
      {:ok, %{status: status}} ->
        {:error, "HTTP Error: Status #{status}"}
      {:error, reason} ->
        {:error, reason}
    end
  end
end
