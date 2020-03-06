defmodule ZendeskSearch do
  @moduledoc """
  Documentation for ZendeskSearch.
  """

  @users_file "data/users.json"
  @tickets_file "data/tickets.json"
  @organizations_file "data/organizations.json"

  @doc """
  Hello world.

  ## Examples

      iex> ZendeskSearch.hello()
      :world

  """
  def hello do
    :world
  end

  def load_data() do
    with {:ok, users} <- Utility.JsonParser.parse_json(@users_file),
         {:ok, tickets} <- Utility.JsonParser.parse_json(@tickets_file),
         {:ok, organizations} <- Utility.JsonParser.parse_json(@organizations_file) do
      {:ok, %{"users" => users, "tickets" => tickets, "organizations" => organizations}}
    else
      {:error, error_message} -> {:error, error_message}
      _ -> {:error, "error.search_and_get_results.other"}
    end
  end
end
