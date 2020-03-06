defmodule SearchHelper.DisplayTest do
  use ExUnit.Case
  doctest SearchHelper.Display
  import SearchHelper.Display

  test "get display field" do
    {:ok, data} = Utility.JsonParser.parse_json("test/data/test.json")
    assert get_display_field(data) === ["_id", "active", "list", "name"]
  end
end
