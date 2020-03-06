defmodule PerformSearch do
  @moduledoc """
  Documentation for PerformSearch
  """
  @resource_names ["users", "tickets", "organizations"]

  @doc """
  Main search function
  prepared_data: %{"users" => users, "tickets" => tickets, "organizations" => organizations}
  resource_name: "users" | "tickets" | "organizations"
  field_name: "_id", "name"...
  search_term: "search_this_text"
  """
  @spec search_and_get_results(map, String.t(), String.t(), String.t() | Integer | Boolean) ::
          list
  def search_and_get_results(prepared_data, resource_name, field_name, search_term)
      when resource_name in @resource_names do
    case SearchHelper.Search.search_on_field(
           prepared_data,
           field_name,
           search_term,
           resource_name
         ) do
      {:ok, results} -> {:ok, results}
      {:error, error_message} -> {:error, error_message}
      _ -> {:error, "error.search_and_get_results.other"}
    end
  end

  def search_and_get_results(_resource_name, _field_name, _search_term),
    do: {:error, "error.search_and_get_results.invalid_resource"}
end
