defmodule Queue.Agent do
  @moduledoc """
  Agent for work with queue
  """

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> Queue.new() end, name: __MODULE__)
  end

  @doc ~S"""
  Inside element in queue

  ## Examples:

      iex> {:ok, _pid} = Queue.Agent.start_link(nil)
      iex> Queue.Agent.inside("first")
      :ok
      iex> Queue.Agent.out()
      "first"
  """
  @spec inside(any()) :: :ok
  def inside(item) do
    Agent.update(__MODULE__, &update_state(&1, :in, item))
  end

  @doc ~S"""
  Outside element of queue

  ## Examples:

      iex> {:ok, _pid} = Queue.Agent.start_link(nil)
      iex> Queue.Agent.inside("first")
      :ok
      iex> Queue.Agent.out()
      "first"
  """
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
