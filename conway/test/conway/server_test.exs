defmodule Conway.ServerTest do
  use ExUnit.Case
  alias Conway.Server

  test "show board" do
    assert ".....\n.....\n.***.\n.....\n....." = Server.show()
  end

  test "next board" do
    assert ".....\n..*..\n..*..\n..*..\n....." = Server.next_board()
  end

  test "count neighbours" do
    assert 2 = Server.count_neighbours({2, 2})
  end
end
