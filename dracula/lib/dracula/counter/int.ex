defmodule Dracula.Counter.Int do
  def new(str) do
    String.to_integer(str)
  end

  def inc(input) do
    input + 1
  end

  def dec(input) do
    input - 1
  end

  def show(input) do
    "The ants arrrr #{input}"
  end
end
