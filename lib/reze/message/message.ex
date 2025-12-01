defmodule Reze.Message.User do
  defstruct [:content, role: :user]
end

defmodule Reze.Message.System do
  defstruct [:content, role: :system, prompt: :reze_default_prompt]
end
