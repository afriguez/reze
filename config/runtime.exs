import Config

adapter =
  case System.get_env("LLM_PROVIDER") do
    "deepseek" -> Reze.LLM.Adapters.Deepseek
    _ -> Reze.LLM.Adapters.Deepseek
  end

config :reze, llm_adapter: adapter
