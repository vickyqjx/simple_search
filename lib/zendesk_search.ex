defmodule ZendeskSearch do
  @moduledoc """
  Documentation for ZendeskSearch.
  """

  @users_file "data/users.json"
  @tickets_file "data/tickets.json"
  @organizations_file "data/organizations.json"

  @resources ["users", "organizations", "tickets"]

  def main(_argv) do
    IO.puts("""
    Loading data
    """)

    {:ok, [users, tickets, organizations, fields]} = load_data()

    user_input(users, tickets, organizations, fields)
  end

  def user_input(users, tickets, organizations, fields) do
    resource_index =
      ExPrompt.choose("Which one you want to search", ~w(Users Organizations Tickets))

    resource = Enum.at(@resources, resource_index)

    IO.puts("""
    PERFECT!
    Your name is `#{resource}``
    """)

    field_index = ExPrompt.choose("Which one you want to search", fields[resource])
    field = Enum.at(fields[resource], field_index)

    search_term = ExPrompt.string_required("Search for?\s")

    {:ok, rs} =
      PerformSearch.search_and_get_results(
        %{"users" => users, "tickets" => tickets, "organizations" => organizations},
        resource,
        field,
        search_term
      )

    Enum.map(rs, fn data_set ->
      IO.puts("---------------#{data_set["_id"]}---------------")

      Enum.map(data_set, fn {key, value} ->
        IO.puts("#{key}:\s#{value}\s")
      end)

      IO.puts("--------------------------------------")
    end)

    sure? = ExPrompt.confirm("Continue?")

    if sure?, do: user_input(users, tickets, organizations, fields), else: IO.puts("\nSee you!")
  end

  def load_data() do
    with {:ok, users} <- Utility.JsonParser.parse_json(@users_file),
         {:ok, tickets} <- Utility.JsonParser.parse_json(@tickets_file),
         {:ok, organizations} <- Utility.JsonParser.parse_json(@organizations_file) do
      {:ok,
       [
         users,
         tickets,
         organizations,
         %{
           "users" => SearchHelper.Display.get_display_field(users),
           "organizations" => SearchHelper.Display.get_display_field(organizations),
           "tickets" => SearchHelper.Display.get_display_field(tickets)
         }
       ]}
    else
      {:error, error_message} -> {:error, error_message}
      _ -> {:error, "error.search_and_get_results.other"}
    end
  end
end
