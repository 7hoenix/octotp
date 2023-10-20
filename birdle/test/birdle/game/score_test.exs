defmodule Birdle.Game.ScoreTest.Macros do
  alias Birdle.Game.Score

  defp expected_score(guess, score) do
    Enum.zip(
      String.graphemes(guess),
      score
      |> String.graphemes()
      |> Enum.map(fn color_letter ->
        case color_letter do
          "G" -> :green
          "Y" -> :yellow
          _ -> :black
        end
      end)
    )
  end

  defmacro birdle_test(answer, guess, score) do
    quote do
      test unquote("#{answer} #{guess}") do
        assert Score.new(unquote(answer), unquote(guess)) == unquote(expected_score(guess, score))
      end
    end
  end
end

defmodule Birdle.Game.ScoreTest do
  use ExUnit.Case
  doctest Birdle.Game.Score

  import Birdle.Game.ScoreTest.Macros

  alias Birdle.Game.Score

  birdle_test("apple", "apple", "GGGGG")
  birdle_test("apple", "snowy", "BBBBB")
  birdle_test("apple", "apply", "GGGGB")
  birdle_test("crane", "czrze", "GBYBG")
  birdle_test("apple", "ppple", "BGGGG")
  birdle_test("abcde", "bcdeb", "YYYYB")
  birdle_test("abcde", "ccbze", "YBYBG")
  birdle_test("aaabb", "bbbaa", "YYBYY")
  birdle_test("applp", "ppple", "YGGGB")
  birdle_test("epplp", "ppple", "YGGGY")
  birdle_test("pappl", "pppla", "GYGYY")
  birdle_test("xoxoo", "oxxxo", "YYGBG")
  birdle_test("clamp", "colly", "GBYBB")
  birdle_test("close", "cheer", "GBYBB")
  birdle_test("close", "cocas", "GYBBY")
  birdle_test("close", "leave", "YBBBG")
  birdle_test("abide", "speed", "BBYBY")
  birdle_test("erase", "speed", "YBYYB")
  birdle_test("steal", "speed", "GBGBB")
  birdle_test("crepe", "speed", "BYGYB")
  birdle_test("steal", "teeth", "YBGBB")
  birdle_test("bonus", "bunny", "GYGBB")
  birdle_test("bunny", "ninen", "YBGBB")
end
