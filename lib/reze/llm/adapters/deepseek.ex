defmodule Reze.LLM.Adapters.Deepseek do
  @behaviour Reze.LLM.Adapter

  def chat(_prompt, _opts) do
    {:ok, "Response"}
  end
end
