defmodule Wordle.Core.ComputeColors do
  @answer "spore"

  @doc """
  Wordle.Core.ComputeColors.execute/1 takes the guess and assigns colors to the characters of each guess
  """
  @spec execute(String.t(), String.t()) :: tuple()
  def execute(guess, answer \\ @answer) do
    # goal = {greens, yellows, blacks}
    greens = get_greens(guess, answer)

    # blacks = guess -- ans
    blacks = get_blacks(guess, answer)

    # yellows = guess -- (greens ++ blacks)
    yellows = get_yellows(guess, blacks ++ greens)

    greens
    |> prepare_response(blacks, yellows)
  end

  @doc """
  gets the correct characters of the guess in the correct positions
  """
  @spec get_greens(String.t(), String.t()) :: list()
  def get_greens(guess, answer) do
    guess
    |> positional_data(answer)
    |> Enum.reduce([], fn {{g, a}, index}, acc ->
      if a == g do
        List.insert_at(acc, -1, {g, index})
      else
        acc
      end
    end)
  end

  @doc """
  gets the wrong characters of the guess
  """
  @spec get_blacks(String.t(), String.t()) :: list()
  def get_blacks(guess, answer) do
    guesses = guess
    |> guesses(answer)
    |> remove_index()

    answer = guess
    |> answer(answer)
    |> remove_index()

    # assign index.
    guesses -- answer
    |> Enum.map(fn letter ->
      index = Enum.find_index(guesses, fn g -> letter == g end)
      {letter, index}
    end)
  end

  @doc """
  gets the characters that are correct but in the wrong positions
  """
  def get_yellows(guess, blacks_and_greens) do
     guesses(guess, @answer) -- blacks_and_greens
  end

  defp guesses(guess, answer) do
    guess
    |> positional_data(answer)
    |> Enum.map(fn {{g, _a}, index} ->
      {g, index}
    end)
  end

  defp answer(guess, answer) do
    guess
    |> positional_data(answer)
    |> Enum.map(fn {{_g, a}, index} ->
      {a, index}
    end)
  end

  defp positional_data(guess, answer) do
    guess
    |> String.graphemes()
    |> Enum.zip(String.graphemes(answer))
    |> Enum.with_index()
  end

  defp remove_index(list) do
    list
    |> Enum.reduce([], fn {item, _index}, acc ->
      List.insert_at(acc, -1, item)
    end)
  end

  defp prepare_response(greens, blacks, yellows) do
    {formatter(greens), formatter(yellows), formatter(blacks)}
  end

  defp formatter(list) when is_list(list) do
    list
    |> Enum.reduce("", fn {letter, index}, acc ->
      "#{acc}#{letter}#{index}"
    end)
  end
end
