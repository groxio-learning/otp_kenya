defmodule Conway do
  @moduledoc """
  API to interact with conway game of life service
  """

  alias Conway.Service

  def new() do
    {:ok, board} = Service.start_link(nil)
    board
  end

  def next_generation(board) do
    GenServer.call(board, :next_gen) |> print_board()
  end

  def show_board(board) do
    GenServer.call(board, :show_board) |> print_board()
  end

  defp print_board(board) do
    IO.puts(board)
  end
end
