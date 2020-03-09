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
        data,
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
        |> Enum.filter(fn {_k, value} -> value !== nil && value !== [] end)
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

  defp item_matches_query?(field_value, search_term) when is_bitstring(field_value),
    do:
      String.downcase(field_value) == String.downcase(search_term) ||
        String.contains?(String.downcase(field_value), String.downcase(search_term))

  defp item_matches_query?(field_value, search_term), do: field_value == search_term

  defp append_associated_data(
         item,
         %{"tickets" => tickets, "organizations" => organizations} = _data,
         "users"
       ) do
    item
    |> Map.put("organization", find_item_by_id(organizations, item["organization_id"]))
    |> Map.drop(["organization_id"])
    |> Map.put(
      "submitted_tickets",
      find_items_by_field_value(tickets, "submitter_id", item["_id"])
    )
    |> Map.put(
      "assigned_tickets",
      find_items_by_field_value(tickets, "assignee_id", item["_id"])
    )
  end

  defp append_associated_data(
         item,
         %{"users" => users, "organizations" => organizations} = _data,
         "tickets"
       ) do
    item
    |> Map.put("submitter", find_item_by_id(users, item["submitter_id"]))
    |> Map.put("assignee", find_item_by_id(users, item["assignee_id"]))
    |> Map.put("organization", find_item_by_id(organizations, item["organization_id"]))
    |> Map.drop(["submitter_id", "assignee_id", "organization_id"])
  end

  defp append_associated_data(
         item,
         %{"tickets" => tickets, "users" => users} = _data,
         "organizations"
       ) do
    item
    |> Map.put(
      "tickets",
      find_items_by_field_value(tickets, "organization_id", item["_id"])
    )
    |> Map.put(
      "users",
      find_items_by_field_value(users, "organization_id", item["_id"])
    )
  end

  defp append_associated_data(item, _data, _resource_name), do: item

  defp find_item_by_id(items, id) do
    Enum.find(items, fn item ->
      item["_id"] == id
    end)
  end

  defp find_items_by_field_value(items, field, value) do
    Enum.filter(items, fn item ->
      item[field] == value
    end)
  end
end
