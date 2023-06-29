defmodule Wordle.GameTest do
  use ExUnit.Case

  alias Wordle.Core.Game

  describe "new_game" do
    test "initialises a new game" do
      game = Game.new_game("noise")

      assert game.word == "noise"
      assert game.state == :initializing
      assert game.turns_left == 6
    end
  end

  describe "guess_word/2" do
    test "recognizes a won or lost game" do
      game = Game.new_game("noise")

      for state <- [:won, :lost] do
        game = %{game | state: state}

        {new_game, _score} = Game.guess_word(game, "uncle")
        assert new_game == game
      end
    end

    test "correct word wins game" do
      game = Game.new_game("noise")

      {new_game, _score} = Game.guess_word(game, "noise")

      assert new_game.state == :won
      assert new_game.turns_left == 5
      assert  new_game.guessed == [%{"e" => "green", "i" => "green",  "n" => "green",  "o" => "green", "s" => "green"}]
    end

    test "can handle a lost game" do
      [
        ["world", :continue, 5, [
          %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"}
          ]],
        ["downs", :continue, 4, [
          %{"d" => "green", "n" => "gray", "o" => "green", "s" => "gray", "w" => "green"},
           %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"}
        ]],
        ["world", :continue, 3, [
          %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"},
          %{"d" => "green", "n" => "gray", "o" => "green", "s" => "gray", "w" => "green"},
          %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"}
        ]],
        ["downs", :continue, 2, [
          %{"d" => "green", "n" => "gray", "o" => "green", "s" => "gray", "w" => "green"},
           %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"},
          %{"d" => "green", "n" => "gray", "o" => "green", "s" => "gray", "w" => "green"},
          %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"}
        ]],
        ["world", :continue, 1, [
          %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"},
          %{"d" => "green", "n" => "gray", "o" => "green", "s" => "gray", "w" => "green"} ,
          %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"},
          %{"d" => "green", "n" => "gray", "o" => "green", "s" => "gray", "w" => "green"},
          %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"}
        ]],
        ["world", :lost, 0, [
          %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"},
          %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"},
          %{"d" => "green", "n" => "gray", "o" => "green", "s" => "gray", "w" => "green"} ,
          %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"},
          %{"d" => "green", "n" => "gray", "o" => "green", "s" => "gray", "w" => "green"},
          %{"d" => "green", "l" => "gray", "o" => "green", "r" => "gray", "w" => "yellow"}
        ]],

      ] |> test_many_moves()
    end
  end

  def test_many_moves(moves) do
    game = Game.new_game("dowed")
    Enum.reduce(moves, game, &check_move/2)
  end

  defp check_move([guess, state, turns_left, guessed], game) do
    {updated_game, score} = Game.guess_word(game, guess)

    assert score.state == state
    assert score.turns_left == turns_left
    assert score.guessed == guessed

    updated_game
  end
end
