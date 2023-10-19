defmodule Birdle.Game.Board do
  alias Birdle.Game.Words
  alias Birdle.Game.Score

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
    board.guesses_reversed
    |> Enum.map(fn guess ->
      Score.new(board.answer, guess)
      |> Score.show()
    end)
    |> Enum.reverse()
    |> Enum.join("\n")
  end
end
