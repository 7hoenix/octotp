defmodule Birdle.Game.Words do
  # check membership - take a MapSet and a word and determine where it's a member or not - eventually in GenServer or ets

  {:ok, contents} = File.read("../words.txt")
  @list String.split(contents, "\n", trim: true)
  @set MapSet.new(@list)

  def random do
    Enum.random(@list)
  end
end
