defmodule Queue.Agent do
  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> Queue.new() end, name: __MODULE__)
  end

  @spec inside(any()) :: :ok
  def inside(item) do
    Agent.update(__MODULE__, &update_state(&1, :in, item))
  end

  @spec out :: any()
  def out do
    {item, _} = Agent.get(__MODULE__, fn queue -> Queue.out(queue) end)

    Agent.update(__MODULE__, &update_state(&1, :out))

    item
  end

  defp update_state(queue, :in, item) do
    Queue.inside(queue, item)
  end

  defp update_state(queue, :out) do
    {_, queue} = Queue.out(queue)

    queue
  end
end
