defmodule Dracula.Counter.StructTest do
  use ExUnit.Case

  alias Dracula.Counter.Struct

  test "crc" do
    result =
      "7"
      |> Struct.new()
      |> assert_count(7)
      |> Struct.inc()
      |> assert_count(8)
      |> Struct.inc()
      |> assert_count(9)
      |> Struct.dec()
      |> assert_count(8)
      |> Struct.show()

    assert "ahoy m8ty" == result
  end

  def assert_count(acc, count) do
    assert acc.count == count
    acc
  end
end
