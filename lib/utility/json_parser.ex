defmodule JsonParser do
  @moduledoc """
  Documentation for JsonParser.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ZendeskSearch.hello()
      :world

  """
  @spec parse_json(String.t()) :: {:ok, list} | {:error, String.t()}
  def parse_json(file_path) do
    with {:ok, body} <- File.read(file_path),
         {:ok, list_of_data} <- Poison.decode(body) do
      {:ok, list_of_data}
    else
      _ -> {:error, "error.JsonParser.parse_json"}
    end
  end

  @spec parse_json(String.t(), String.t() | Integer) :: {:ok, map} | {:error, String.t()}
  def parse_json(file_path, key) do
    with {:ok, list_of_data} <- parse_json(file_path),
         {:ok, map_of_data} <- DataFormatter.convert_list_to_map(list_of_data, key) do
      {:ok, map_of_data}
    else
      _ -> {:error, "error.JsonParser.parse_json"}
    end
  end
end
