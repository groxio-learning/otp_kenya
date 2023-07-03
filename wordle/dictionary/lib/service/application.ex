defmodule Dictionary.Service.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      { Dictionary.Service.Server, [nil] }
    ]

    options = [
      name: Dictionary.Service.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, options)
  end
end
