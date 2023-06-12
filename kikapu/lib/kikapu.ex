defmodule Kikapu do
  @moduledoc """
  API for Kikapu Service
  """

  alias Kikapu.ServiceOTP, as: Server

  def new(input \\ []) do
    {:ok, kikapu} = Server.start_link(input)
    kikapu
  end

  def add(kikapu, key, value) do
    GenServer.cast(kikapu, {:add, key, value})
  end

  def remove(kikapu, key) do
    GenServer.cast(kikapu, {:remove, key})
  end

  def get(kikapu, key) do
    GenServer.call(kikapu, {:get, key})
  end
end
