defmodule Wordle do
  @moduledoc """
  Guess a 5 lettered word in 6 attempts
  """

  alias Wordle.Service.Server
  alias Wordle.Type

  @opaque game :: Server.t
  @type score :: Type.score

  @spec guess_word(String.t()) :: {:ok, score} | {:error, String.t()}
  def guess_word(guess) do
    if Dictionary.is_member?(guess) do
      GenServer.call(:wordle, {:guess_word, guess})
    else
      GenServer.call(:wordle, :not_a_word)
    end
  end

  @spec game_score() :: score
  def game_score() do
    GenServer.call(:wordle, :score)
  end
end
