defmodule Dictionary.Service.Server do
  use Agent

  @moduledoc """
  An agent to hold list of words to avoid reading the file everytime the app is started
  """
  alias Dictionary.Core.WordList

  @type t :: pid

  @name __MODULE__

  def start_link(_) do
    Agent.start_link(&WordList.word_list/0, name: @name)
  end

  @spec random_word() :: String.t
  def random_word do
    Agent.get(@name, &WordList.random_word/1)
  end
end
