defmodule Reze.LLM.Adapter do
  alias Reze.Message, as: Msg

  @callback chat(messages :: list(Msg.User | Msg.System), opts :: Keyword.t()) ::
              {:ok, response :: String.t()} | {:error, reason :: term()}
end
