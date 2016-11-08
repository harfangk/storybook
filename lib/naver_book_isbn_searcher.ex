defmodule Storybook.NaverBookISBNSearcher do
  import SweetXml
  @name __MODULE__

  def start_link do
    Agent.start_link(fn -> [] end, name: @name)
  end

  def send_query(isbn) do
    Agent.update(@name, &do_send_query(&1, isbn))
  end

  def get_query_result() do
    Agent.get(@name, &(&1))
  end

  defp do_send_query(_list, isbn) do
    result =
      isbn
      |> fetch_xml()
      |> parse_xml()
      |> convert_charlist_to_string()
      |> convert_fields()
    result
  end

  @http Application.get_env(:storybook, :naver)[:http_client] || :httpc
  defp fetch_xml(isbn) do
    url = String.to_char_list("https://openapi.naver.com/v1/search/book_adv.xml" <> "?d_isbn=#{isbn}")
    headers = [
               {'X-Naver-Client-Id', String.to_char_list("#{app_id()}")}, 
               {'X-Naver-Client-Secret', String.to_char_list("#{app_secret()}")}
              ]
    {:ok, {_, _, body}} = @http.request(:get, {url, headers}, [], [])
    body
  end

  defp parse_xml(xml) do
    xml
    |> xpath(
      ~x"//channel/item"l,
      title: ~x"./title/text()",
      description: ~x"./description/text()",
      publisher: ~x"./publisher/text()",
      published_date: ~x"./pubdate/text()",
      author: ~x"./author/text()",
      isbns: ~x"./isbn/text()",
      image: ~x"./image/text()",
    )
  end

  defp convert_charlist_to_string(list) do
    converted_list = 
      list
      |> Enum.map(fn query_result -> for {key, val} <- query_result, into: %{}, do: {key, to_string(val)} end)
    converted_list
  end

  defp convert_fields(list) do
    list
    |> Enum.map(&convert_isbn_field(&1))
    |> Enum.map(&convert_author_field(&1))
    |> Enum.map(&convert_image_field(&1))
  end

  defp convert_isbn_field(map) do
    map[:isbns]
    |> String.split()
    |> Enum.each(&assign_isbns_to_correct_fields(&1, map))
    Map.delete(map, :isbns)
  end

  defp convert_author_field(map) do
    map
    |> Map.put(:authors, String.split(map[:author], "|"))
    |> Map.delete(:author)
  end

  defp convert_image_field(map) do
    map
    |> Map.put(:image_small, map[:image])
    |> Map.put(:image_medium, hd(String.split(map[:image], "?")))
    |> Map.delete(:image)
  end

  defp assign_isbns_to_correct_fields(isbn_code, map) do
    cond do
      String.length(isbn_code) == 10 -> Map.put(map, :isbn10, isbn_code)
      String.length(isbn_code) == 13 -> Map.put(map, :isbn13, isbn_code)
    end
  end

  defp app_id, do: Application.get_env(:storybook, :naver)[:app_id]
  defp app_secret, do: Application.get_env(:storybook, :naver)[:app_secret]
end
