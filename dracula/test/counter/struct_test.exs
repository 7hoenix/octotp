defmodule Dracula.Counter.StructTest do
  use ExUnit.Case

  alias Dracula.Counter.Struct

  test "crc" do
    result =
      "7"
      |> Struct.new()
      |> Struct.inc()
      |> Struct.inc()
      |> Struct.dec()
      |> Struct.show()

    assert "ahoy m8ty" == result
  end
end
