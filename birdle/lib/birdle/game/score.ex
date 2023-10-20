defmodule Birdle.Game.Score do
  def new(answer, guess) do
    answer_letters = String.graphemes(answer)
    guess_letters = String.graphemes(guess)

    missing = guess_letters -- answer_letters

    zipped = Enum.reverse(Enum.zip(answer_letters, guess_letters))

    only_greens_marked =
      Enum.map(zipped, fn {a, g} ->
        if a == g do
          {g, :green}
        else
          {g, :yellow}
        end
      end)
      |> Enum.with_index()

    set_blacks = Enum.reduce(missing, only_greens_marked, &replace_one_letter/2)

    Enum.reverse(Enum.map(set_blacks, &elem(&1, 0)))
  end

  defp replace_one_letter(letter, acc) do
    {{let, col}, index} =
      replacement =
      Enum.find(acc, fn {{l, c}, i} ->
        c == :yellow and letter == l
      end)

    List.replace_at(acc, index, {{let, :black}, index})
  end

  def show(score) do
    Enum.map(score, &color_character/1)
  end

  defp color_character({char, color}) do
    color_ =
      case color do
        :black ->
          IO.ANSI.light_black_background() <> IO.ANSI.white()

        :yellow ->
          IO.ANSI.yellow_background() <> IO.ANSI.black()

        :green ->
          IO.ANSI.green_background() <> IO.ANSI.black()
      end

    color_ <> char <> IO.ANSI.reset()
  end
end
