defmodule Reze.Message.User do
  defstruct [:content, role: :user]
end

defmodule Reze.Message.System do
  defstruct [:content, role: :system, prompt: :reze_default_prompt]
end

defmodule Reze.Message.Assistant do
  defstruct [:content, role: :assistant]
end
