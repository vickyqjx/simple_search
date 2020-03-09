defmodule SearchHelper.Search do
  @moduledoc """
  Documentation for SearchHelper.Search
  """

  @doc """
  search data on field, return matched results
  """
  @spec search_on_field(map, String.t(), String.t() | Integer | Boolean, String.t()) ::
          {:ok, list}
  def search_on_field(
        %{"users" => users, "tickets" => tickets, "organizations" => organizations} = data,
        field_name,
        search_term,
        resource_name
      ) do
    results =
      data[resource_name]
      |> Enum.filter(fn item -> item_matches_query?(item[field_name], search_term) end)
      |> Enum.map(fn item ->
        item
        |> append_associated_data(data, resource_name)
        |> Enum.filter(fn {k, value} -> value !== nil && value !== [] end)
        |> Enum.into(%{})
      end)

    {:ok, results}
  end

  @spec search_on_field(list, String.t(), String.t(), String.t() | Integer | Boolean) ::
          {:ok, list}
  def search_on_field(list, field_name, search_term) do
    results = Enum.filter(list, fn item -> item_matches_query?(item[field_name], search_term) end)
    {:ok, results}
  end

  defp item_matches_query?(nil, ""), do: true
  defp item_matches_query?(nil, _search_term), do: false

  defp item_matches_query?(field_value, search_term) when is_list(field_value),
    do: Enum.member?(field_value, search_term)

  defp item_matches_query?(field_value, search_term) when is_integer(field_value),
    do: Integer.to_string(field_value) == search_term or field_value == search_term

  defp item_matches_query?(field_value, search_term) when is_boolean(field_value),
    do: to_string(field_value) == search_term or field_value == search_term

  defp item_matches_query?(field_value, search_term), do: field_value == search_term

  defp append_associated_data(item, data, "users") do
    item
  end

  defp append_associated_data(
         item,
         data,
         "organizations"
       ) do
    item
  end

  defp append_associated_data(
         item,
         %{"users" => users, "organizations" => organizations} = data,
         "tickets"
       ) do
    item
    |> Map.put("submitter", find_item_by_id(users, item["submitter_id"]))
    |> Map.put("assignee", find_item_by_id(users, item["assignee_id"]))
    |> Map.put("organization", find_item_by_id(organizations, item["organization_id"]))
  end

  defp append_associated_data(item, _data, _resource_name), do: item

  defp find_item_by_id(items, id) do
    Enum.find(items, fn item ->
      item["_id"] == id
    end)
  end
end
