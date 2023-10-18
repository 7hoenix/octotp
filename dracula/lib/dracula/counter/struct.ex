defmodule Dracula.Counter.Struct do
  defstruct count: 0

  @spec new(binary()) :: %__MODULE__{}
  def new(string_val) do
    %__MODULE__{
      count: String.to_integer(string_val)
    }
  end

  def inc(acc) do
    %{acc | count: acc.count + 1}
  end

  def dec(acc) do
    %{acc | count: acc.count - 1}
  end

  def show(struct) do
    "ahoy m#{struct.count}ty"
  end
end
