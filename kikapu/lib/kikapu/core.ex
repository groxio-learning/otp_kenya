defmodule Kikapu.Core do
  # generic datatype: Map

  # inputs [{:one, 1}, {:two, 2}]
  def new(inputs) do
    Map.new(inputs)
  end

  def add(map, key, value) do
    Map.put(map, key, value)
  end

  def remove(map, key) do
    Map.delete(map, key)
  end

  def get(map, key) do
    Map.get(map, key)
  end
end
