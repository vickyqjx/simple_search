defmodule Utility.DataFormatter do
  @moduledoc """
  Documentation for Utility.DataFormatter.
  """

  @doc """
  convert list to map

  ## Examples

      iex> convert_list_to_map([%{"_id"=>"11", "name" => "User1"}, %{"_id"=>"22", "name" => "User2"}], key)
      %{"11" => %{"_id"=>"11", "name" => "User1"}, "22" => %{"_id"=>"22", "name" => "User2"}}

  """
  @spec convert_list_to_map(list, String.t() | Integer) :: map
  def convert_list_to_map(data_as_list, key) do
    data_as_list
    |> Enum.map(fn row -> {row[key], row} end)
    |> Map.new()
  end
end
