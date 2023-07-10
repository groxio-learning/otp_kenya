defmodule Wordle.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    IO.puts "Wordle starting..."
    children = [
      {Wordle.Service.Server, :deadpool},
      {Wordle.Service.Server, :green_lanten},
      {Wordle.Service.Server, :megamind},
      {Wordle.Service.Server, :batman},
      {Wordle.Service.Server, :groot}
    ]

    opts = [strategy: :one_for_one, name: Wordle.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
