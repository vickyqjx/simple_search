defmodule Utility.JsonParser do
  @moduledoc """
  Documentation for Utility.JsonParser.
  """

  @doc """
  Read a JSON file, convert it to a list
  """
  @spec parse_json(String.t()) :: {:ok, list} | {:error, String.t()}
  def parse_json(file_path) do
    with {:ok, body} <- File.read(file_path),
         {:ok, data_as_list} <- Poison.decode(body) do
      {:ok, data_as_list}
    else
      _ -> {:error, "error.JsonParser.parse_json"}
    end
  end

  @doc """
  Read a JSON file, convert it to a map
  """
  @spec parse_json(String.t(), String.t() | Integer) :: {:ok, map} | {:error, String.t()}
  def parse_json(file_path, key) do
    with {:ok, data_as_list} <- parse_json(file_path),
         data_as_map <- Utility.DataFormatter.convert_list_to_map(data_as_list, key) do
      {:ok, data_as_map}
    else
      _ -> {:error, "error.JsonParser.parse_json"}
    end
  end
end
