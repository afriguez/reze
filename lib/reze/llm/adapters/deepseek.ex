defmodule Reze.LLM.Adapters.Deepseek do
  alias Reze.LLM.Adapters.Deepseek.API
  @behaviour Reze.LLM.Adapter

  def chat(prompt, opts) do
    # {:ok, "Response"}
    API.chat(prompt, opts)
  end
end

defmodule Reze.LLM.Adapters.Deepseek.API do
  use HTTPoison.Base

  @domain "https://api.deepseek.com"

  def headers do
    [
      {"Authorization", "Bearer " <> Application.get_env(:reze, :deepseek_token)},
      {"Content-Type", "application/json"}
    ]
  end

  def process_url(url) do
    @domain <> url
  end

  def chat(prompt, _opts) do
    content = %{
      "model" => Application.get_env(:reze, :deepseek_model),
      "messages" => [
        %{
          role: "user",
          content: prompt
        }
      ],
      "stream" => false
    }

    {:ok, %HTTPoison.Response{body: body}} =
      post("/chat/completions", Poison.encode!(content), headers(), recv_timeout: 60_000)

    Poison.decode(body)
  end
end
