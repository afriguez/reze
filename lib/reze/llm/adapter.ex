defmodule Reze.LLM.Adapter do
  @callback chat(prompt :: String.t(), opts :: Keyword.t()) ::
              {:ok, response :: String.t()} | {:error, reason :: term()}
end
