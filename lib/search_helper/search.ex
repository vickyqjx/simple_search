defmodule SearchHelper.Search do
  @moduledoc """
  Documentation for SearchHelper.Search
  """

  @doc """
  search data on field, return matched results
  """
  @spec search_on_field(list, String.t(), String.t() | Integer | Boolean) :: {:ok, list}
  def search_on_field(list, field_name, search_term) do
    results = Enum.filter(list, fn item -> item_matches_query?(item[field_name], search_term) end)
    {:ok, results}
  end

  defp item_matches_query?(nil, ""), do: true
  defp item_matches_query?(nil, search_term), do: false

  defp item_matches_query?(field_value, search_term) when is_list(field_value),
    do: Enum.member?(field_value, search_term)

  defp item_matches_query?(field_value, search_term), do: field_value == search_term
end
