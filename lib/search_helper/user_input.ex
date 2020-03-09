defmodule SearchHelper.UserInput do
  @moduledoc """
  Documentation for SearchHelper.UserInput
  """

  @resources ["users", "organizations", "tickets"]

  @helper_msg_resources "Please select dataset from above to search"
  @helper_msg_fields "Please select a field above"
  @helper_msg_term "Please enter the search term:"

  @error_msg_invalid "\n\nInvalid input! Please try again!"

  def get_user_input(:resource_name),
    do: get_options_input(:resource_name, @resources, @helper_msg_resources, @error_msg_invalid)

  def get_user_input(:search_term), do: ExPrompt.string(@helper_msg_term)

  def get_user_input(:field_name, field_names),
    do: get_options_input(:field_name, field_names, @helper_msg_fields, @error_msg_invalid)

  def get_options_input(input_field, options, helper_message, error_message) do
    index =
      ExPrompt.choose(
        "#{helper_message}(#{1} ~ #{Enum.count(options)}):\s",
        options
      )

    if is_integer(index) and index >= 0 and
         index <= Enum.count(options) do
      Enum.at(options, index - 1)
    else
      IO.puts(error_message)
      get_user_input(input_field, options)
    end
  end
end
