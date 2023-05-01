defmodule Conway.Rules do
  @moduledoc """
  Do fun things with big loud worker bees

  **Data**, **Functions**, **Tests**, Boundaries, Lifecycles, Workers

  CRC - Construct, Reduce, Convert

  Conway's game rules
  1.
  """

  def next_cell(_alive, neighbours) when neighbours < 2 do
    false
  end

  def next_cell(alive, 2) do
    alive
  end

  def next_cell(_alive, 3) do
    true
  end

  def next_cell(_alive, neighbours) when neighbours > 3 do
    false
  end
end
