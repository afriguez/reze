import Config

adapter =
  case System.get_env("LLM_PROVIDER") do
    "deepseek" -> Reze.LLM.Adapters.Deepseek
    _ -> Reze.LLM.Adapters.Deepseek
  end

config :reze,
  llm_adapter: adapter,
  deepseek_token: System.get_env("DEEPSEEK_API_KEY"),
  deepseek_model: System.get_env("DEEPSEEK_API_MODEL")
