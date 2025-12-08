defmodule Reze.LLM.Adapters.Deepseek do
  @behaviour Reze.LLM.Adapter
  alias Reze.LLM.Adapters.Deepseek.API

  def chat(messages), do: API.chat(messages)
  def chat!(messages), do: API.chat!(messages)
  def chat_stream(messages), do: API.chat_stream(messages)
end
