defmodule Utility.DataFormatter do
  @moduledoc """
  Documentation for Utility.DataFormatter.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ZendeskSearch.hello()
      :world

  """
  @spec convert_list_to_map(list, String.t() | Integer) :: map
  def convert_list_to_map(data_as_list, key) do
    data_as_list
    |> Enum.map(fn row -> {row[key], row} end)
    |> Map.new()
  end
end
