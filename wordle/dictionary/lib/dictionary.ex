defmodule Dictionary do
  @moduledoc """
  Returns a random 5 letter word
  """
  alias Dictionary.Service.Server

  @spec random_word :: String.t
  defdelegate random_word(), to: Server

  @spec word_list :: list(String.t)
  defdelegate word_list(), to: Server

  @spec is_member?(String.t) :: boolean
  defdelegate is_member?(guess), to: Server
end
