defmodule JsonParserTest do
  use ExUnit.Case
  doctest Utility.JsonParser
  import Utility.JsonParser

  test "read JSON file, get data as a list or a map" do
    data_as_list = [
      %{
        "_id" => 1,
        "active" => true,
        "list" => ["test_list_1", "test_list_2"],
        "name" => "test_1"
      },
      %{
        "_id" => 2,
        "active" => false,
        "list" => ["test_list_3", "test_list_4"],
        "name" => "test_2"
      }
    ]

    data_as_map = %{
      1 => %{
        "_id" => 1,
        "active" => true,
        "list" => ["test_list_1", "test_list_2"],
        "name" => "test_1"
      },
      2 => %{
        "_id" => 2,
        "active" => false,
        "list" => ["test_list_3", "test_list_4"],
        "name" => "test_2"
      }
    }

    # read JSON, and get data as a list
    assert parse_json("test/data/test.json") == {:ok, data_as_list}

    # read JSON, and get data as a list
    assert parse_json("test/data/test.json", "_id") == {:ok, data_as_map}

    # error
    assert parse_json("test/data/unknown.json") == {:error, "error.JsonParser.parse_json"}
    assert parse_json("test/data/unknown.json", "_id") == {:error, "error.JsonParser.parse_json"}
  end
end
