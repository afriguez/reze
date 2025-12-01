defmodule Reze.Message.Handler do
  alias Reze.Message
  alias Reze.LLM.Client

  def handle(messages, opts) do
    Client.chat(messages, opts)
  end
end
