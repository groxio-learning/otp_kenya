defmodule Wordle.Service.Server do
  @moduledoc """
  GenServer to manage state of a game
  """
  use GenServer

  @type t :: pid

  alias Wordle.Core.Game

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  @impl true
  def init(_) do
    { :ok, Game.new_game() }
  end

  @impl true
  def handle_call({:guess_word, guess}, _from, game) do
    {updated_game, score} = Game.guess_word(game, guess)

    {:reply, score, updated_game}
  end

  @impl true
  def handle_call(:score, _from, game) do
    {:reply, Game.score(game), game}
  end
end
