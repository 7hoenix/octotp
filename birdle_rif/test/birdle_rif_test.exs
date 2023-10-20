defmodule BirdleRifTest do
  use ExUnit.Case
  doctest BirdleRif

  test "greets the world" do
    assert BirdleRif.hello() == :world
  end
end
