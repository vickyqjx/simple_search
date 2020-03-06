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
end
