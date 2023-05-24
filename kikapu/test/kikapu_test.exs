defmodule KikapuTest do
  use ExUnit.Case
  doctest Kikapu

  test "greets the world" do
    assert Kikapu.hello() == :world
  end
end
