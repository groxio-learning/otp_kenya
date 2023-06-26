defmodule Wordle.GameTest do
  use ExUnit.Case

  alias Wordle.Core.Game

  defp create_game(_) do
    %{game: Game.new_game("noise")}
  end

  describe "new_game" do
    setup [:create_game]

    test "initialises a new game", %{game: game} do
      assert game.word == "noise"
      assert game.state == :initializing
      assert game.turns_left == 6
    end
  end

  describe "guess_word/2" do
    setup [:create_game]

    test "recognizes a won or lost game", %{game: game} do
      for state <- [:won, :lost] do
        game = %{game | state: state}

        {new_game, _score} = Game.guess_word(game, "uncle")
        assert new_game == game
      end
    end

    test "correct word wins game", %{game: game} do
      {new_game, _score} = Game.guess_word(game, "noise")

      assert new_game.state == :won
      assert new_game.turns_left == 5
      assert  new_game.guessed == [%{"e" => "green", "i" => "green",  "n" => "green",  "o" => "green", "s" => "green"}]
    end
  end

  # todo: test sequence of moves, test losing game
end
