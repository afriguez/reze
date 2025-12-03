defmodule Reze.LLM.Client do
  @behaviour Reze.LLM.Adapter

  def chat(messages, opts \\ []), do: adapter().chat(messages, opts)
  def chat!(messages, opts), do: adapter().chat!(messages, opts)
  defp adapter, do: Application.get_env(:reze, :llm_adapter)
end
