defmodule Kikapu.Service do
  alias Kikapu.Core

  # convenience on client process
  def new(input \\ []) do
    spawn(fn -> input |> Core.new() |> loop() end)
  end

  def add(pid, key, value) do
    send(pid, {:add, key, value})
  end
  def remove(pid, key) do
    send(pid, {:remove, key})
  end
  def get(pid, key) do
    send(pid, {:get, self(), key})
    receive do
      m -> m
    end
  end

  # on server process
  def loop(map) do
    map
    |> listen()
    |> loop()
  end

  def listen(map) do
    receive do
      {:add, key, value} ->
        Core.add(map, key, value)
      {:get, from, key} ->
        result = Core.get(map, key)
        send(from, result)
        map
      {:remove, key} ->
        Core.remove(map, key)
    end

    # check ...listen for message...
    # ...if the user needs a value, we send it to them...
    # ...return the new state for the service...

  end
end
