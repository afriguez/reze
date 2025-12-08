defmodule Reze.LLM.Adapter do
  alias Reze.LLM.Adapters.Deepseek.Stream
  alias Reze.Message, as: Msg

  @callback chat(messages :: list(Msg.User | Msg.System | Msg.Assistant)) ::
              {:ok, response :: Msg.Assistant} | {:error, reason :: term()}

  @callback chat!(messages :: list(Msg.User | Msg.System | Msg.Assistant)) ::
              response :: Msg.Assistant

  @callback chat_stream(messages :: list(Msg.User | Msg.System | Msg.Assistant)) ::
              response :: Stream
end
