defmodule BirdleTest do
  use ExUnit.Case
  doctest Birdle

  test "greets the world" do
    assert Birdle.hello() == :world
  end
end
