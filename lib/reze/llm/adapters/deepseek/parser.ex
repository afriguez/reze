defmodule Reze.LLM.Adapters.Deepseek.Parser do
  def decode_body(body), do: Poison.decode(body)

  def extract_sync_response(%{
        "choices" => [%{"message" => %{"content" => content}} | _]
      }),
      do: {:ok, content}

  def extract_sync_response(_), do: {:error, :bad_response}

  def parse_sse_chunk(chunk) do
    chunk
    |> String.split("\n")
    |> Enum.flat_map(fn
      "data: [DONE]" ->
        []

      "data: " <> json ->
        case Poison.decode(json) do
          {:ok,
           %{
             "choices" => [%{"delta" => %{"content" => token}}]
           }} ->
            [token]

          _ ->
            []
        end

      _ ->
        []
    end)
  end
end
