defmodule Reze.LLM.Adapters.Deepseek.Stream do
  alias Reze.LLM.Adapters.Deepseek.{HTTP, Parser, Config}

  def start(messages) do
    Stream.resource(
      fn -> start_request(messages) end,
      fn ref -> next_chunk(ref) end,
      fn _ref -> :ok end
    )
  end

  defp start_request(messages) do
    body =
      Poison.encode!(%{
        "model" => Config.model(),
        "messages" => messages,
        "stream" => true
      })

    {:ok, %HTTPoison.AsyncResponse{id: ref}} =
      HTTP.post(
        "/chat/completions",
        body,
        HTTP.headers(),
        stream_to: self(),
        recv_timeout: :infinity,
        async: :once
      )

    ref
  end

  defp next_chunk(ref) do
    receive do
      %HTTPoison.AsyncStatus{id: ^ref} ->
        HTTPoison.stream_next(%HTTPoison.AsyncResponse{id: ref})
        {[], ref}

      %HTTPoison.AsyncHeaders{id: ^ref} ->
        HTTPoison.stream_next(%HTTPoison.AsyncResponse{id: ref})
        {[], ref}

      %HTTPoison.AsyncChunk{id: ^ref, chunk: chunk} ->
        tokens = Parser.parse_sse_chunk(chunk)
        HTTPoison.stream_next(%HTTPoison.AsyncResponse{id: ref})
        {tokens, ref}

      %HTTPoison.AsyncEnd{id: ^ref} ->
        {:halt, ref}
    end
  end
end
