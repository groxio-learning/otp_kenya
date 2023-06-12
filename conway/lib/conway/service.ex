defmodule Conway.Service do
  use GenServer
  @moduledoc """
  Conway OTP Server
  """

  alias Conway.Board

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  #SERVER
  @impl true
  def init(_) do
    {:ok, Board.new()}
  end

  @impl true
  def handle_call(:next_gen, _from, board) do
    next_gen = Board.next_board(board)

    {:reply, Board.show(next_gen), next_gen}
  end

  @impl true
  def handle_call(:show_board, _from, board) do
    {:reply, Board.show(board), board}
  end

end
