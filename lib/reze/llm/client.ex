defmodule Reze.LLM.Client do
  @behaviour Reze.LLM.Adapter

  def chat(messages), do: adapter().chat(messages)
  def chat!(messages), do: adapter().chat!(messages)
  def chat_stream(messages), do: adapter().chat_stream(messages)
  defp adapter, do: Application.get_env(:reze, :llm_adapter)
end
