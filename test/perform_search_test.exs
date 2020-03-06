defmodule PerformSearchTest do
  use ExUnit.Case
  doctest PerformSearch
  import PerformSearch

  @tickets_json_file "test/data/tickets.json"
  @matched_item %{
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
  @unmatched_item %{
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

  test "give the resource name, search text on field, and get the results" do
    prepared_data = %{
      "users" => [],
      "tickets" => [@matched_item, @unmatched_item],
      "organizations" => []
    }

    assert search_and_get_results(prepared_data, "tickets", "priority", "low") ===
             {:ok, [@matched_item]}

    assert search_and_get_results(prepared_data, "tickets", "priority", "") ===
             {:ok, []}

    assert search_and_get_results(prepared_data, "tickets", "description", "") ===
             {:ok, [@matched_item]}
  end
end
