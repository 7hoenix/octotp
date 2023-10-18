defmodule Dracula.Counter.HexDigitsTest do
  use ExUnit.Case
  doctest Dracula.Counter.HexDigits

  alias Dracula.Counter.HexDigits

  test "contruct works" do
    assert HexDigits.new("11") == "B"
  end

  test "inc 0 works" do
    assert HexDigits.inc("0") == "1"
  end

  test "inc F works" do
    assert HexDigits.inc("F") == "10"
  end

  test "dec F works" do
    assert HexDigits.dec("F") == "E"
  end
end
