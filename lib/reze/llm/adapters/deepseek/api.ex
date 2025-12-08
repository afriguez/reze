defmodule Reze.LLM.Adapters.Deepseek.API do
  alias Reze.LLM.Adapters.Deepseek.{Config, HTTP, Parser, Stream}

  @endpoint "/chat/completions"

  def chat(messages) do
    try do
      assistant = chat!(messages)
      {:ok, assistant}
    rescue
      e -> {:error, format_error(e)}
    end
  end

  def chat!(messages) do
    payload = %{
      "model" => Config.model(),
      "messages" => messages,
      "stream" => false
    }

    body =
      HTTP.post(
        @endpoint,
        Poison.encode!(payload),
        HTTP.headers(),
        recv_timeout: 60_000
      )
      |> case do
        {:ok, %HTTPoison.Response{body: body}} -> body
        {:error, %HTTPoison.Error{reason: reason}} -> raise "HTTP Error: #{inspect(reason)}"
      end

    decoded =
      case Parser.decode_body(body) do
        {:ok, map} -> map
        {:error, reason} -> raise "JSON Decode Error: #{inspect(reason)}"
      end

    case Parser.extract_sync_response(decoded) do
      {:ok, content} -> %Reze.Message.Assistant{content: content}
      {:error, :bad_response} -> raise "Unexpected API response shape"
    end
  end

  def chat_stream(messages), do: Stream.start(messages)

  def format_error(%_module{} = exc), do: Exception.message(exc)
  def format_error(err), do: inspect(err)
end
