defmodule SearchHelper.DisplayTest do
  use ExUnit.Case
  doctest SearchHelper.Display
  import SearchHelper.Display

  test "get display field" do
    {:ok, data} = Utility.JsonParser.parse_json("test/data/test.json")
    assert get_display_field(data) === ["_id", "active", "list", "name"]
  end

  test "display" do
    rs = %{
      "_id" => "50f3fdbd-f8a6-481d-9bf7-572972856628",
      "assignee" => %{
        "_id" => 12,
        "active" => false,
        "alias" => "Mr Sally",
        "created_at" => "2016-07-21T12:26:16 -10:00",
        "email" => "sallyhammond@flotonic.com",
        "external_id" => "38899b1e-89ca-43e7-b039-e3c88525f0d2",
        "last_login_at" => "2012-12-29T07:59:56 -11:00",
        "locale" => "en-AU",
        "name" => "Watkins Hammond",
        "organization_id" => 110,
        "phone" => "8144-293-283",
        "role" => "end-user",
        "shared" => false,
        "signature" => "Don't Worry Be Happy!",
        "suspended" => false,
        "tags" => ["Bonanza", "Balm", "Fulford", "Austinburg"],
        "timezone" => "United Kingdom",
        "url" => "http://initech.zendesk.com/api/v2/users/12.json",
        "verified" => false
      },
      "assignee_id" => 12,
      "created_at" => "2016-05-19T08:52:06 -10:00",
      "description" =>
        "Cillum laboris ad ex reprehenderit dolor velit tempor ea id ut veniam. Excepteur sunt ullamco qui est laboris veniam ut commodo tempor ea laborum.",
      "due_at" => "2016-08-01T11:48:58 -10:00",
      "external_id" => "bf080887-362a-4311-90be-a23cbacf712f",
      "has_incidents" => false,
      "organization" => %{
        "_id" => 125,
        "created_at" => "2016-02-21T06:11:51 -11:00",
        "details" => "MegaCorp",
        "domain_names" => ["techtrix.com", "teraprene.com", "corpulse.com", "flotonic.com"],
        "external_id" => "42a1a845-70cf-40ed-a762-acb27fd606cc",
        "name" => "Strezzö",
        "shared_tickets" => false,
        "tags" => ["Vance", "Ray", "Jacobs", "Frank"],
        "url" => "http://initech.zendesk.com/api/v2/organizations/125.json"
      },
      "organization_id" => 125,
      "priority" => "normal",
      "status" => "pending",
      "subject" => "A Nuisance in Namibia",
      "submitter" => %{
        "_id" => 66,
        "active" => true,
        "alias" => "Mr Fernandez",
        "created_at" => "2016-04-11T10:08:08 -10:00",
        "email" => "fernandezpoole@flotonic.com",
        "external_id" => "e29c3611-d1f2-492e-a805-594e239ff922",
        "last_login_at" => "2014-03-18T05:42:21 -11:00",
        "locale" => "en-AU",
        "name" => "Geneva Poole",
        "organization_id" => 114,
        "phone" => "8925-633-579",
        "role" => "admin",
        "shared" => true,
        "signature" => "Don't Worry Be Happy!",
        "suspended" => true,
        "tags" => ["Whitehaven", "Omar", "Waiohinu", "Catharine"],
        "timezone" => "Aruba",
        "url" => "http://initech.zendesk.com/api/v2/users/66.json",
        "verified" => true
      },
      "submitter_id" => 66,
      "tags" => ["Maine", "West Virginia", "Michigan", "Florida"],
      "type" => "incident",
      "url" =>
        "http://initech.zendesk.com/api/v2/tickets/50f3fdbd-f8a6-481d-9bf7-572972856628.json",
      "via" => "voice"
    }

    assert get_display_data_set(rs) ===
             "\nId:  50f3fdbd-f8a6-481d-9bf7-572972856628\nAssignee:  \n  - Watkins Hammond (ID:12)\nAssignee_id:  \nCreated_at:  2016-05-19T08:52:06 -10:00\nDescription:  Cillum laboris ad ex reprehenderit dolor velit tempor ea id ut veniam. Excepteur sunt ullamco qui est laboris veniam ut commodo tempor ea laborum.\nDue_at:  2016-08-01T11:48:58 -10:00\nExternal_id:  bf080887-362a-4311-90be-a23cbacf712f\nHas_incidents:  \nOrganization:  \n  - Strezzö (ID:125)\nOrganization_id:  \nPriority:  normal\nStatus:  pending\nSubject:  A Nuisance in Namibia\nSubmitter:  \n  - Geneva Poole (ID:66)\nSubmitter_id:  \nTags:  Maine,West Virginia,Michigan,Florida\nType:  incident\nUrl:  http://initech.zendesk.com/api/v2/tickets/50f3fdbd-f8a6-481d-9bf7-572972856628.json\nVia:  voice"
  end
end
