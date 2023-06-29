defmodule Dictionary.Core.WordList do
  @moduledoc """
  Reads word list file and returns list of words
  """

  @type t :: list(String.t)

  @spec word_list() :: t
  def word_list do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/, trim: true)
    |> MapSet.new()
  end

  @spec random_word(t) :: String.t
  def random_word(word_list) do
    Enum.random(word_list)
  end
end
