defmodule Reze.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Reze.Message.History, max_messages: 7},
      {Bandit, plug: Reze.Server.Router, scheme: :http}
    ]

    opts = [strategy: :one_for_one, name: Reze.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
