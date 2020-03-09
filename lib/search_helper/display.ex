defmodule SearchHelper.Display do
  @moduledoc """
  Documentation for SearchHelper.Display
  """

  def get_display_field(list) do
    list
    |> Enum.map(&Map.keys/1)
    |> Enum.concat()
    |> Enum.uniq()
  end

  def get_display_data_set(data_set) do
    data_set
    |> format_display_data()
    |> Enum.map(fn {key, value} ->
      display_key =
        key |> String.trim_leading("_") |> String.replace("_", " ") |> String.capitalize()

      "\n#{display_key}:\s\s#{get_field_value(value)}"
    end)
    |> Enum.join()
  end

  defp format_display_data(%{"created_at" => created_at} = data) do
    # DateTime.from_iso8601(created_at)
    data
  end

  defp format_display_data(data) do
    data
  end

  defp get_field_value(%{"name" => name, "_id" => id}) do
    "\n\s\s-\s#{name}\s(ID:#{id})"
  end

  defp get_field_value(value) when is_list(value) do
    Enum.map(value, fn v ->
      if is_map(v) do
        "\n\s\s-\s#{v["name"]}\s(ID:#{v["_id"]})"
      else
        v
      end
    end)
    |> Enum.join(",")
  end

  defp get_field_value(value) do
    value
  end
end
