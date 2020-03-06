defmodule PerformSearch do
  @moduledoc """
  Documentation for PerformSearch
  """
  @resource_names ["users", "tickets", "organizations"]

  @resources_path "data/"

  @doc """
  Main search function
  resource_name: "users" | "tickets" | "organizations"
  resource_path "data/users.json"
  field_name: "_id", "name"...
  search_term: "search_this_text"
  """
  @spec search_and_get_results(String.t(), String.t(), String.t() | Integer | Boolean, atom) ::
          list
  def search_and_get_results(resource_name, field_name, search_term, :name)
      when resource_name in @resource_names do
    search_and_get_results(
      "#{@resources_path}#{resource_name}.json",
      field_name,
      search_term,
      :path
    )
  end

  def search_and_get_results(_resource_name, _field_name, _search_term, :name) do
    {:error, "error.search_and_get_results.invalid_resource"}
  end

  def search_and_get_results(resource_path, field_name, search_term, :path) do
    with {:ok, json_data} <-
           Utility.JsonParser.parse_json(resource_path),
         {:ok, search_results} <-
           SearchHelper.Search.search_on_field(json_data, field_name, search_term) do
      {:ok, search_results}
    else
      {:error, error_message} -> {:error, error_message}
      _ -> {:error, "error.search_and_get_results.other"}
    end
  end
end
