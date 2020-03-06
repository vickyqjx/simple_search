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
    "submitter_id" => 71,
    "assignee_id" => 38,
    "organization_id" => 112
  }

  test "give the resource name, search text on field, and get the results" do
    assert search_and_get_results(@tickets_json_file, "priority", "low", :path) ===
             {:ok, [@matched_item]}

    assert search_and_get_results(@tickets_json_file, "priority", "", :path) ===
             {:ok, []}

    assert search_and_get_results(@tickets_json_file, "description", "", :path) ===
             {:ok, [@matched_item]}
  end
end
