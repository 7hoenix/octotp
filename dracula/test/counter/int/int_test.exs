defmodule Counter.IntTest do
  use ExUnit.Case

  test "converts string to integer if string is a textual representation of an integer" do
    assert Dracula.Counter.Int.new("32") == 32
    assert Dracula.Counter.Int.new("0") == 0
    assert Dracula.Counter.Int.new("2408") == 2408
  end

  test "increments an integer by one" do
    assert Dracula.Counter.Int.inc(32) == 33
    assert Dracula.Counter.Int.inc(0) == 1
    assert Dracula.Counter.Int.inc(2408) == 2409
  end

  test "decrements an integer by one" do
    assert Dracula.Counter.Int.dec(33) == 32
    assert Dracula.Counter.Int.dec(1) == 0
    assert Dracula.Counter.Int.dec(2409) == 2408
  end

  test "returns string The ants arrrr -input-" do
    assert Dracula.Counter.Int.show(32) == "The ants arrrr 32"
    assert Dracula.Counter.Int.show(0) == "The ants arrrr 0"
    assert Dracula.Counter.Int.show(2408) == "The ants arrrr 2408"
  end

  test "CRC!" do
    assert "32" |> Dracula.Counter.Int.new |> Dracula.Counter.Int.inc |> Dracula.Counter.Int.dec |> Dracula.Counter.Int.show == "The ants arrrr 32"
  end
end
