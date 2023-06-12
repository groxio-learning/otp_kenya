defmodule Kikapu.ServiceOTP do
  use GenServer

  alias Kikapu.Core

  # CLIENT
  def start_link(input \\ []) do
    GenServer.start_link(__MODULE__, Core.new(input))
  end

  # SERVER
  @impl true
  def init(kikapu) do
    {:ok, kikapu}
  end

  @impl true
  def handle_cast({:add, key, value}, kikapu) do
    {:noreply, Core.add(kikapu, key, value)}
  end

  @impl true
  def handle_cast({:remove, key}, kikapu) do
    {:noreply, Core.remove(kikapu, key)}
  end

  @impl true
  def handle_call({:get, key}, _from, kikapu) do
    {:reply, Core.get(kikapu, key), kikapu}
  end
end
