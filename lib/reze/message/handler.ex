defmodule Reze.Message.Handler do
  alias Reze.Message.{History, Assistant}
  alias Reze.LLM.Client

  def handle(message) do
    History.add(message)

    History.all()
    |> Client.chat!()
    |> History.add()
  end

  def handle(message, stream?: true), do: handle_stream(message)

  def handle_stream(message) do
    History.add(message)

    token_stream =
      History.all()
      |> Client.chat_stream()

    Stream.resource(
      fn ->
        %{acc: "", stream: token_stream}
      end,
      fn %{acc: acc, stream: stream} = state ->
        case Enum.take(stream, 1) do
          [] ->
            final_message = %Assistant{content: acc}
            History.add(final_message)
            {:halt, state}

          [token] ->
            {[token], %{state | acc: acc <> token}}
        end
      end,
      fn _ -> :ok end
    )
  end
end
