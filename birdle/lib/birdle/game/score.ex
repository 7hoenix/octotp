defmodule Birdle.Game.Score do

  def new(answer, guess) do
    answer_char_map =
      answer
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(%{}, &answer_to_char_map/2)

    guess_chars =
      guess
      |> String.graphemes()
      |> Enum.with_index()

    Enum.map(guess_chars, &char_score(&1, answer_char_map))
  end

  defp answer_to_char_map({char, index}, acc) do
    Map.update(acc, char, [index], fn positions -> [index | positions] end)
  end

  defp char_score({char, index}, answer_char_map) do
    color =
      answer_char_map
      |> Map.get(char)
      |> then(&get_color(&1, index))

    {char, color}
  end

  defp get_color(nil, _index), do: :black

  defp get_color(positions, index) do
    if Enum.any?(positions, index) do
      :green
    else
      :yellow
    end
  end

  def show(score) do
    # TODO: show the score
  end
end
