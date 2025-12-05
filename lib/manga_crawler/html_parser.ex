defmodule MangaCrawler.Parser do
  # Giả định module Config đã được nạp chính xác từ HOCON
  alias MangaCrawler.Config

  # --- 1. PARSE DANH SÁCH SERIES (INDEX PAGE) ---

  @doc """
  Trích xuất danh sách Series từ HTML dựa trên cấu hình Source.
  """
  def parse_series_list(source_name, html_body) when is_binary(source_name) and is_binary(html_body) do
    %{selectors: selectors} = get_source_selectors!(source_name)

    case Floki.parse_document(html_body) do
      {:ok, parsed_html} ->
        parsed_html
        |> Floki.find(selectors["SeriesList"])
        |> Enum.map(&extract_series_data(&1, selectors))
        |> Enum.reject(&is_nil/1)

      {:error, _reason} ->
        []
    end
  end

  defp extract_series_data(series_element, selectors) do
    link_element = Floki.find(series_element, selectors["SeriesTitle"])

    case Enum.at(link_element, 0) do
      nil -> nil
      link ->
        title = Floki.text(link)

        url = Floki.attribute(selectors["SeriesLinkAttr"], link)

        %{
          title: title,
          slug: Path.basename(url),
          url: url
        }
    end
  end

  @doc """
  Trích xuất danh sách URL ảnh và số trang cho một Chapter.
  """
  def parse_chapter_pages(source_name, html_body) when is_binary(source_name) and is_binary(html_body) do
    %{selectors: selectors} = get_source_selectors!(source_name)

    {:ok, parsed_html} = Floki.parse_document(html_body)

    parsed_html
    |> Floki.find(selectors["ChapterImageContainer"])
    |> Enum.with_index()
    |> Enum.map(fn {img_element, index} ->
      image_url_result = Floki.attribute(img_element, selectors["ChapterImageSrcAttr"])

      case image_url_result do
        [image_url | _] when is_binary(image_url) ->
          page_number_result = Floki.attribute(img_element, selectors["ChapterImagePageAttr"])

          page_number = case page_number_result do
            [num | _] when is_binary(num) ->
              String.to_integer(num)
            _ ->
              index + 1
          end

          %{
            image_url: image_url,
            page_number: page_number
          }
        _ ->
          nil
      end
    end)
    |> Enum.reject(&is_nil/1)
  end

  defp get_source_selectors!(source_name) do
    config = Config.get_source_config(source_name)

    case config do
      nil ->
        raise "Configuration for source '#{source_name}' not found in HOCON."
      %{ "Selectors" => selectors } ->
        %{selectors: selectors}
      _ ->
        raise "Selectors section not found in HOCON config for '#{source_name}'."
    end
  end
end
