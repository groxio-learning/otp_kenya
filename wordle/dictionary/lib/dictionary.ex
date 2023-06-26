defmodule Dictionary do
  @moduledoc """
  Returns a random 5 letter word
  """
  alias Dictionary.Service.Server

  @doc """
  Random word

  ## Examples

      iex> Dictionary.random_word()
      "pluto"

  """
  @spec random_word :: String.t
  defdelegate random_word(), to: Server

  @spec word_list :: list(String.t)
  defdelegate word_list(), to: Server
end
