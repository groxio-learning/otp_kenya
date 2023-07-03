defmodule Wordle.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    IO.puts "Wordle starting..."
    children = [
      {Wordle.Service.Server, []}
    ]

    opts = [strategy: :one_for_one, name: Wordle.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
