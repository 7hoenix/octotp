defmodule BirdleRif do

  def mark(answer, guess) do
    [answers, guesses] =
      [answer, guess]
      |> Enum.map(&String.graphemes/1)

    misses = guesses -- answers

    mark(answers, guesses, misses, [])
  end

  def mark([], _, _, acc), do: Enum.reverse(acc)

  # greens
  def mark([same|answers], [same|guesses], misses, acc) do
    mark(answers, guesses, misses, [{same, :green}|acc])
  end
  # blacks and yellows
  def mark([_a|answers], [g|guesses], misses, acc) do
    if g in misses do
      mark(answers, guesses, List.delete(misses, g), [{g, :black}|acc])
    else
      mark(answers, guesses, misses, [{g, :yellow}|acc])
    end
  end

  def mark2(answer, guess) do
    [answers, guesses] =
      [answer, guess]
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.reverse/1)
    mark2(answers, guesses, guesses -- answers, [])
  end

  def mark2([], _guesses, _misses, acc), do: acc
  def mark2([a|answers], [g|guesses], misses, acc) do
    {color, m} =
      cond do
        a == g ->
          {:green, misses}
        g in misses ->
          {:black, List.delete(misses, g)}
        true ->
          {:yellow, misses}
      end
    mark2(answers, guesses, m, [{g, color}|acc])
  end

  def mark_one({a, g}, {misses, results}) do
    cond do
      a == g ->
        {misses, [{g, :green}|results]}
      g in misses ->
        remaining_misses = List.delete(misses, g)
        {remaining_misses, [{g, :black}|results]}
      true ->
        {misses, [{g, :yellow}|results]}
    end
  end

  def mark3(answer, guess) do
    [answers, guesses] =
      [answer, guess]
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.reverse/1)

    acc = {guesses -- answers, []}

    Enum.reduce(Enum.zip(answers, guesses), acc, &mark_one/2)
  end

  def mark4(answer, guess) do
    [answers, guesses] =
      [answer, guess]
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.reverse/1)

    acc = {guesses -- answers, []}

    Enum.reduce(
      Enum.zip(answers, guesses),
      acc,
      fn {a, g}, {misses, results} ->
        cond do
          a == g ->
            {misses, [{g, :green}|results]}
          g in misses ->
            remaining_misses = List.delete(misses, g)
            {remaining_misses, [{g, :black}|results]}
          true ->
            {misses, [{g, :yellow}|results]}
        end
      end)
      |> elem(1)
  end
end
