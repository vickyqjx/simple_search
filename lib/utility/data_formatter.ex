defmodule DataFormatter do
  @moduledoc """
  Documentation for DataFormatter.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ZendeskSearch.hello()
      :world

  """
  @spec convert_list_to_map(list, String.t() | Integer) :: map
  def convert_list_to_map(list_of_data, key) do
    Enum.map(list_of_data, fn data ->
      {data[key], data}
    end)
  end
end
