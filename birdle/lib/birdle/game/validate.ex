defmodule Birdle.Game.Validate do
  alias Birdle.Game.Words

  def validate(guess, previous_guesses) do
    cond do
      String.length(guess) != 5 ->
        {:error, :must_be_5_characters}

      Enum.find(previous_guesses, &(&1 == guess)) != nil ->
        {:error, :already_guessed}

      not Words.member?(guess) ->
        {:error, :unknown_word}

      true ->
        :ok
    end
  end
end
