defmodule Wordle do
  @moduledoc """
  Guess a 5 lettered word in 6 attempts
  """

  alias Wordle.Service.Server
  alias Wordle.Type

  @opaque game :: Server.t
  @type score :: Type.score

  @spec guess_word(String.t()) :: {:ok, score} | {:error, String.t()}
  def guess_word(name \\ :wordle, guess) do
    if Dictionary.is_member?(guess) do
      GenServer.call(name, {:guess_word, guess})
    else
      GenServer.call(name, :not_a_word)
    end
  end

  @spec game_score() :: score
  def game_score(name \\ :wordle) do
    GenServer.call(name, :score)
  end
end
