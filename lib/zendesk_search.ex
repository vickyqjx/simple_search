defmodule ZendeskSearch do
  @moduledoc """
  Documentation for ZendeskSearch.
  """

  alias SearchHelper.UserInput, as: UserInput
  alias SearchHelper.Search, as: Search
  alias SearchHelper.Display, as: Display

  @users_file "data/users.json"
  @tickets_file "data/tickets.json"
  @organizations_file "data/organizations.json"

  @resources ["users", "organizations", "tickets"]

  @welcome_msg "*** Welcome to Zendesk Search! ***\n"
  @loading_msg "Please wait while your data is loading...\n"
  @start_msg "Ready! Please start your search."

  @helper_msg_resources "Please select dataset from above to search"
  @helper_msg_fields "Please select a field above in "
  @helper_msg_term "Please enter the search term for "

  @error_msg_invalid "\n\nInvalid input! Please try again!"

  @error_msg_search_results "\nSearch error!"

  @no_results_message "\nNo matching results!"

  @divider "\n---------------------------------------"

  def main(_argv) do
    IO.puts("#{@welcome_msg}\n#{@loading_msg}")

    {:ok, [users, tickets, organizations, fields]} =
      load_data([@users_file, @tickets_file, @organizations_file])

    IO.puts(@start_msg)
    user_input({users, tickets, organizations}, fields)
  end

  def user_input({users, tickets, organizations}, fields) do
    IO.puts(@divider)

    resource_name =
      UserInput.get_options_input(@resources, @helper_msg_resources, @error_msg_invalid)

    select_fields_message = "#{@helper_msg_fields}[#{resource_name}]\s"

    IO.puts(@divider)

    field_name =
      UserInput.get_options_input(
        fields[resource_name],
        select_fields_message,
        @error_msg_invalid
      )

    IO.puts(@divider)
    search_term = ExPrompt.string("#{@helper_msg_term}[#{field_name}]:")

    prepared_data = %{"users" => users, "tickets" => tickets, "organizations" => organizations}

    case Search.search_on_field(prepared_data, field_name, search_term, resource_name) do
      {:ok, rs} -> display_search_results(rs)
      _ -> IO.puts(@error_msg_search_results)
    end

    sure? = ExPrompt.confirm("\n#{@divider}\n\nContinue?")

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

  def display_search_results(results) when length(results) == 0 do
    IO.puts(@no_results_message)
  end

  def display_search_results(results) do
    output =
      Enum.map(results, fn data_set ->
        "\n#{Display.get_display_data_set(data_set)}"
      end)

    IO.puts("\n********* #{length(results)} matched results! *********#{output}/n")
  end
end
