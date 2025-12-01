defmodule Reze.Message.History do
  use GenServer

  @table :message_history

  @impl true
  def init(opts) do
    :ets.new(@table, [:ordered_set, :public, :named_table])
    {:ok, opts}
  end

  def start_link(opts) do
    max_messages = Keyword.fetch!(opts, :max_messages)
    GenServer.start_link(__MODULE__, %{max: max_messages}, name: __MODULE__)
  end

  def add(message) do
    GenServer.cast(__MODULE__, {:add, message})
  end

  def all() do
    :ets.tab2list(@table)
    |> Enum.sort_by(fn {id, _message} -> id end)
    |> Enum.map(fn {_id, message} -> message end)
  end

  @impl true
  def handle_cast({:add, message}, %{max: max} = state) do
    id = System.system_time(:microsecond)
    :ets.insert(@table, {id, message})

    trim(max)

    {:noreply, state}
  end

  defp trim(max_messages) do
    size = :ets.info(@table, :size)

    if size > max_messages do
      to_delete = size - max_messages

      oldest =
        :ets.first(@table)
        |> collect_old_keys(to_delete, [])

      Enum.each(oldest, &:ets.delete(@table, &1))
    end
  end

  defp collect_old_keys(_key, 0, acc), do: Enum.reverse(acc)
  defp collect_old_keys(:"$end_of_table", _n, acc), do: Enum.reverse(acc)

  defp collect_old_keys(key, n, acc) do
    next = :ets.next(@table, key)
    collect_old_keys(next, n - 1, [key | acc])
  end
end
