defmodule Reze.LLM.Adapters.Deepseek.HTTP do
  use HTTPoison.Base
  alias Reze.LLM.Adapters.Deepseek.Config

  def process_url(url), do: Config.base_url() <> url

  def headers do
    [
      {"Authorization", "Bearer " <> Config.token()},
      {"Content-Type", "application/json"}
    ]
  end
end
