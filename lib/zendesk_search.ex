defmodule ZendeskSearch do
  @moduledoc """
  Documentation for ZendeskSearch.
  """

  alias SearchHelper.UserInput, as: UserInput

  @users_file "data/users.json"
  @tickets_file "data/tickets.json"
  @organizations_file "data/organizations.json"

  @resources ["users", "organizations", "tickets"]

  @welcome_msg "*** Welcome to Zendesk Search! ***\n"
  @loading_msg "Please wait while your data is loading...\n"
  @start_msg "Ready! Please start your search."

  @helper_msg_resources "Please select dataset from above to search"
  @helper_msg_fields "Please select a field above"
  @helper_msg_term "Please enter the search term:"

  @error_msg_invalid "\n\nInvalid input! Please try again!"

  @error_msg_search_results "\nSearch error!"

  def main(_argv) do
    IO.puts("#{@welcome_msg}\n#{@loading_msg}")

    {:ok, [users, tickets, organizations, fields]} =
      load_data([@users_file, @tickets_file, @organizations_file])

    IO.puts(@start_msg)
    user_input({users, tickets, organizations}, fields)
  end

  def user_input({users, tickets, organizations}, fields) do
    resource_name =
      UserInput.get_options_input(@resources, @helper_msg_resources, @error_msg_invalid)

    field_name =
      UserInput.get_options_input(fields[resource_name], @helper_msg_fields, @error_msg_invalid)

    search_term = ExPrompt.string(@helper_msg_term)

    prepared_data = %{"users" => users, "tickets" => tickets, "organizations" => organizations}

    case PerformSearch.search_and_get_results(
           prepared_data,
           resource_name,
           field_name,
           search_term
         ) do
      {:ok, rs} ->
        IO.puts("--------------------------------------")

        Enum.map(rs, fn data_set ->
          IO.puts("---------------#{data_set["_id"]}---------------")

          Enum.map(data_set, fn {key, value} ->
            IO.puts("#{key}:\s#{value}\s")
          end)

          IO.puts("--------------------------------------")
        end)

      _ ->
        IO.puts(@error_msg_search_results)
    end

    sure? = ExPrompt.confirm("Continue?")

    if sure?, do: user_input({users, tickets, organizations}, fields), else: IO.puts("\nSee you!")
  end

  def load_data([users_file, tickets_file, organizations_file]) do
    with {:ok, users} <- Utility.JsonParser.parse_json(users_file),
         {:ok, tickets} <- Utility.JsonParser.parse_json(tickets_file),
         {:ok, organizations} <- Utility.JsonParser.parse_json(organizations_file) do
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
