defmodule Wordle.Type do
  @moduledoc false

  @type state :: :initializing | :won | :lost | :not_a_word | :continue

  @type score :: %{
    state: state,
    word: String.t,
    turns_left: integer(),
    guessed: list(map())
  }
end
