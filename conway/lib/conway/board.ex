defmodule Conway.Board do
  @moduledoc """
  {row, column} => true | false
  """

  @rows 5
  @cols 5

  def new() do
    %{
      {3, 2} => true,
      {3, 3} => true,
      {3, 4} => true
    }
  end

  def show(board) do
    Enum.map(1..@rows, &show_row(board, &1))
    |> Enum.join("\n")
  end

  def next_board(board) do
    for r <- 1..@rows, c <- 1..@cols, into: %{} do
      neighbours = count_neighbours(board, {r, c})
      alive = Map.get(board, {r, c}, false)
      next_cell = Conway.Rules.next_cell(alive, neighbours)
      {{r, c}, next_cell}
    end
  end

  def count_neighbours(board, {r, c}) do
    for row <- (r - 1)..(r + 1), col <- (c - 1)..(c + 1), {r, c} != {row, col} do
      Map.get(board, {row, col}, false)
    end
    |> Enum.count(& &1)
  end

  defp show_cell(true), do: "*"
  defp show_cell(false), do: "."

  defp show_row(board, row) do
    for col <- 1..@cols do
      board
      |> Map.get({row, col}, false)
      |> show_cell()
    end
  end
end
