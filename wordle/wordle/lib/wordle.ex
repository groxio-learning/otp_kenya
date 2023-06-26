defmodule Wordle do
  @moduledoc """
  Guess a 5 lettered word in 6 attempts
  """

  alias Wordle.Service.Server
  alias Wordle.Type

  @opaque game :: Server.t
  @type score :: Type.score

  @spec new_game() :: game
  def new_game() do
    {:ok, game} = Server.start_link(nil)
    game
  end

  @spec guess_word(game, String.t()) :: {:ok, score} | {:error, String.t()}
  def guess_word(game, guess) do
    if Dictionary.is_member?(guess) do
      GenServer.call(game, {:guess_word, guess})
    else
      GenServer.call(game, :not_a_word)
    end
  end

  @spec game_score(game) :: score
  def game_score(game) do
    GenServer.call(game, :score)
  end
end
