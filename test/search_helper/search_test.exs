defmodule SearchHelper.SearchTest do
  use ExUnit.Case
  doctest SearchHelper.Search
  import SearchHelper.Search

  test "search on field, return matched results" do
    item_1 = %{
      "_id" => 1,
      "active" => true,
      "list" => ["test_list_1", "test_list_2"],
      "name" => "test_1"
    }

    item_2 = %{
      "_id" => 2,
      "active" => false,
      "list" => ["test_list_3", "test_list_4"],
      "name" => "test_2"
    }

    list = [item_1, item_2]

    assert search_on_field(list, "_id", 1) === {:ok, [item_1]}
    assert search_on_field(list, "name", "test_2") === {:ok, [item_2]}
    assert search_on_field(list, "list", "test_list_3") === {:ok, [item_2]}
    assert search_on_field(list, "active", false) === {:ok, [item_2]}

    assert search_on_field(list, "_id", 3) === {:ok, []}
    assert search_on_field(list, "name", "dummy_name") === {:ok, []}
    assert search_on_field(list, "name", "test") === {:ok, []}
  end
end
