defmodule Reze.LLM.Adapters.Deepseek.Config do
  def token, do: Application.fetch_env!(:reze, :deepseek_token)
  def model, do: Application.fetch_env!(:reze, :deepseek_model)
  def base_url, do: "https://api.deepseek.com"
end
