defmodule SearchHelper.UserInputTest do
  use ExUnit.Case
  doctest SearchHelper.UserInput
  import SearchHelper.UserInput

  test "get user input" do
    count = 3
    options = ["users", "organizations", "tickets"]

    assert get_input_option(-1, count, options) === :error
    assert get_input_option(9, count, options) === :error
    assert get_input_option("unknown", count, options) === :error

    assert get_input_option(0, count, options) === {:ok, "users"}
    assert get_input_option(1, count, options) === {:ok, "organizations"}
    assert get_input_option(2, count, options) === {:ok, "tickets"}
  end
end
