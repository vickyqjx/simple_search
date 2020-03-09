defmodule SearchHelper.UserInput do
  @moduledoc """
  Documentation for SearchHelper.UserInput
  """

  def get_options_input(options, helper_message, error_message) do
    count = Enum.count(options)
    hint_message = "#{helper_message}(#{1} ~ #{count}):\s"
    input_index = ExPrompt.choose(hint_message, options)

    case get_input_option(input_index, count, options) do
      {:ok, option_value} ->
        option_value

      :error ->
        IO.puts(error_message)
        get_options_input(options, helper_message, error_message)
    end
  end

  def get_input_option(input_index, count, options) do
    if is_integer(input_index) and input_index >= 1 and input_index <= count do
      {:ok, Enum.at(options, input_index - 1)}
    else
      :error
    end
  end
end
