defmodule Wordle do
  @moduledoc """
  Guess a 5 lettered word in 6 attempts
  """

  alias Wordle.Service.Server
  alias Wordle.Type

  @opaque game :: Server.t
  @type score :: Type.score

  # TODO: Update lifecycle
  @spec new_game() :: game
  def new_game() do
    {:ok, game} = Server.start_link(nil)
    game
  end

  @spec guess_word(game, String.t()) :: score
  def guess_word(game, guess) do
    GenServer.call(game, {:guess_word, guess})
  end

  @spec game_score(game) :: score
  def game_score(game) do
    GenServer.call(game, :score)
  end
end
