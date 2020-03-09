defmodule SearchHelper.SearchTest do
  use ExUnit.Case
  doctest SearchHelper.Search
  import SearchHelper.Search

  @ticket_1 %{
    "_id" => "1a227508-9f39-427c-8f57-1b72f3fab87c",
    "url" =>
      "http://initech.zendesk.com/api/v2/tickets/1a227508-9f39-427c-8f57-1b72f3fab87c.json",
    "external_id" => "3e5ca820-cd1f-4a02-a18f-11b18e7bb49a",
    "created_at" => "2016-04-14T08:32:31 -10:00",
    "subject" => "A Catastrophe in Micronesia",
    "priority" => "low",
    "assignee_id" => 38,
    "organization_id" => 112
  }
  @ticket_2 %{
    "_id" => "2a227508-9f39-427c-8f57-1b72f3fab87c",
    "url" =>
      "http://initech.zendesk.com/api/v2/tickets/2a227508-9f39-427c-8f57-1b72f3fab87c.json",
    "external_id" => "1e5ca820-cd1f-4a02-a18f-11b18e7bb49a",
    "created_at" => "2016-04-12T08:32:31 -10:00",
    "subject" => "A Catastrophe in Micronesia",
    "priority" => "high",
    "submitter_id" => 71,
    "organization_id" => 112,
    "description" => "Dummy description"
  }

  @user_1 %{
    "_id" => 71,
    "name" => "User 1"
  }

  @user_1 %{
    "_id" => 38,
    "name" => "User 2"
  }

  @organization_1 %{
    "_id" => 112,
    "name" => "organization 1"
  }

  @organization_2 %{
    "_id" => 111,
    "name" => "organization 2"
  }

  @data %{
    "users" => [@user_1, @user_2],
    "tickets" => [@ticket_1, @ticket_2],
    "organizations" => [@organization_1, @organization_2]
  }

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
    assert search_on_field(list, "_id", "1") === {:ok, [item_1]}
    assert search_on_field(list, "name", "test_2") === {:ok, [item_2]}
    assert search_on_field(list, "list", "test_list_3") === {:ok, [item_2]}
    assert search_on_field(list, "active", false) === {:ok, [item_2]}
    assert search_on_field(list, "active", "false") === {:ok, [item_2]}

    assert search_on_field(list, "_id", 3) === {:ok, []}
    assert search_on_field(list, "name", "dummy_name") === {:ok, []}
    assert search_on_field(list, "name", "test") === {:ok, []}
  end

  test "search on field, return matched results with associated data" do
    assert search_on_field(@data, "priority", "high", "tickets") ===
             {:ok, [Map.put(@ticket_2, "organization", @organization_1)]}
  end
end
