defmodule Wordle.Core.Game do
  @moduledoc """
  Rules for wordle game
  """
  alias Wordle.Type

  @type t :: %__MODULE__{
    state: Type.state,
    word: String.t(),
    turns_left: integer(),
    guessed: list(map()),
  }

  defstruct(
    word: nil,
    state: :initializing,
    turns_left: 6,
    guessed: []
  )

  ################# Constructor #################################
  @spec new_game() :: t()
  def new_game() do
    new_game(Dictionary.random_word())
  end

  @spec new_game(String.t) :: t()
  def new_game(word) do
    struct(
      %__MODULE__{},
     [word: word]
     )
  end

  ################# Reducers #################################
  @spec guess_word(t, String.t()) :: {t(), Type.score}
  def guess_word(%__MODULE__{state: state}=game, _guess)
    when state in [:won, :lost] do
    return_with_score(game)
  end

  def guess_word(game, guess) do
    game
    |> score_guess(guess)
    |> return_with_score()
  end

  defp score_guess(%{turns_left: 1}=game, _guess) do
    %{ game | state: :lost, turns_left: 0 }
  end

  defp score_guess(game, guess) do
    new_state = maybe_won?(game.word == guess)
    %{ game |
      state: new_state,
      guessed: [color_guess(game, guess) | game.guessed],
      turns_left: game.turns_left - 1
    }
  end

  defp maybe_won?(true), do: :won
  defp maybe_won?(_), do: :continue

   # Process guess colors
  def color_guess(game, guess) do
    for {guess, index} <- word_with_index(guess), into: %{} do
      guess
      |> is_letter_in_word?(game)
      |> check_guessed_letter(game, guess, index)
    end
  end

  defp word_with_index(word) do
    word
      |> String.codepoints()
      |> Enum.with_index
  end

  defp check_guessed_letter(_in_word=true, %{word: word}=_game, guess, index) do
    word
    |> String.codepoints()
    |> is_at_correct_position?(index, guess)
    |> assign_color_for_correct_position(guess)
  end

  defp check_guessed_letter(_in_word=false, _game, guess, _index) do
     {guess, "gray"}
  end

  defp assign_color_for_correct_position(true, guess) do
    {guess, "green"}
  end

  defp assign_color_for_correct_position(false, guess) do
    {guess, "yellow"}
  end

  defp is_letter_in_word?(guess, _game=%{word: word}) do
    guess in String.codepoints(word)
  end

  defp is_at_correct_position?(word, guess_index, guess) do
    Enum.at(word, guess_index) == guess
  end

  ################# Convertor #################################
  @spec score(t) :: Type.score
  def score(game) do
    %{
      state: game.state,
      word: game.word,
      turns_left: game.turns_left,
      guessed: game.guessed
    }
  end

  defp return_with_score(game) do
    {game, score(game)}
  end
end
