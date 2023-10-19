defmodule Birdle.Game.Board do
  alias Birdle.Game.Words

  defstruct [:answer, :guesses_reversed]

  def new do
    %__MODULE__{
      answer: Words.random(),
      guesses_reversed: []
    }
  end

  def add_guess(acc, guess) do
    %{acc | guesses_reversed: [guess | acc.guesses_reversed]}
  end

  def show(board) do
    # convert to printable version use the score module
  end

  defp row(answer, guess) do
    "guess"
  end
end
