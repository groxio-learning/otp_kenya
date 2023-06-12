defmodule Conway.Server do
  use GenServer

  alias Conway.Board

  # API
  def start_link(board) when is_map(board) do
    GenServer.start_link(__MODULE__, Board.new(), name: __MODULE__)
  end

  def show() do
    GenServer.call(__MODULE__, :show_board)
  end

  def next_board() do
    GenServer.call(__MODULE__, :next_board)
  end

  def count_neighbours({r, c}) do
    GenServer.call(__MODULE__, {:next_board, r, c})
  end

  def shutdown() do
    GenServer.cast(__MODULE__, :shutdown)
  end

  # Callbacks
  @impl true
  def init(board) do
    {:ok, board}
  end

  @impl true
  def handle_call(:show_board, _from, state) do
    {:reply, Board.show(state), state}
  end

  @impl true
  def handle_call(:next_board, _from, state) do
    {:reply, state |> Board.next_board() |> Board.show(), state}
  end

  @impl true
  def handle_call({:next_board, r, c}, _from, state) do
    {:reply, Board.count_neighbours(state, {r, c}), state}
  end

  @impl true
  def handle_cast(:shutdown, state) do
    {:stop, :normal, state}
  end
end
