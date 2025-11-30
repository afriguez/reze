defmodule Reze.LLM.Client do
  @behaviour Reze.LLM.Adapter

  def chat(prompt, opts \\ []), do: adapter().chat(prompt, opts)
  defp adapter, do: Application.get_env(:reze, :llm_adapter)
end
