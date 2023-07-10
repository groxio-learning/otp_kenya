defmodule Wordle.Service.Server do
  @moduledoc """
  GenServer to manage state of a game
  """
  use GenServer

  @type t :: pid

  alias Wordle.Core.Game

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  @impl true
  def init(name) do
    IO.puts "Starting #{name}"
    { :ok, Game.new_game() }
  end

  @impl true
  def handle_call({:guess_word, guess}, _from, game) do
    {updated_game, score} = Game.guess_word(game, guess)

    {:reply, {:ok, score}, updated_game}
  end

  @impl true
  def handle_call(:not_a_word, _from, game) do
    {:reply, {:error, "Not A Word!"}, game}
  end

  @impl true
  def handle_call(:score, _from, game) do
    {:reply, Game.score(game) , game}
  end

  def child_spec(name) do
    %{
      id: name,
      start: {Wordle.Service.Server, :start_link, [name]}
    }
  end
end
