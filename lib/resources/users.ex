defmodule Resources.Users do
  defstruct map: nil, list: nil

  def update(data) do
    Agent.update(:data, fn _data -> data end)
  end

  def fetch() do
    Agent.get(:data, fn data -> data end)
  end
end
