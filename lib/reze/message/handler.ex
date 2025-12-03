defmodule Reze.Message.Handler do
  alias Reze.Message.History
  alias Reze.LLM.Client

  def handle(message, opts) do
    History.add(message)

    History.all()
    |> Client.chat!(opts)
    |> History.add()
  end
end
