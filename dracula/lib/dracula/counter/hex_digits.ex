defmodule Dracula.Counter.HexDigits do
  @moduledoc """
  """

  @doc """
  construct!

  ## Examples

      iex> Dracula.Counter.HexDigits.new("10")
      "A"

  """
  @spec new(String.t()) :: String.t()
  def new(base_ten_string) do
    base_ten_string
    |> String.to_integer()
    |> Integer.to_string(16)
  end

  @doc """
  reduce! (increment)

  ## Examples

      iex> Dracula.Counter.HexDigits.inc("A")
      "B"

  """
  @spec inc(String.t()) :: String.t()
  def inc(acc) do
    acc
    |> String.to_integer(16)
    |> Kernel.+(1)
    |> Integer.to_string(16)
  end

  @doc """
  reduce! (decrement)

  ## Examples

      iex> Dracula.Counter.HexDigits.dec("A")
      "9"

  """
  @spec dec(String.t()) :: String.t()
  def dec(acc) do
    acc
    |> String.to_integer(16)
    |> Kernel.+(-1)
    |> Integer.to_string(16)
  end

  @doc """
  convert!

  ## Examples

      iex> Dracula.Counter.HexDigits.show("A")
      "base ten is 10 and base sixteen is A"

  """
  @spec show(String.t()) :: String.t()
  def show(acc) do
    base_ten =
      String.to_integer(acc, 16)

    "base ten is #{base_ten} and base sixteen is #{acc}"
  end

end
