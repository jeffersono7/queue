defmodule Queue do
  @moduledoc """
  Module for work queue.
  """

  @keys [:queue]

  @enforce_keys @keys
  defstruct @keys

  @type t :: %__MODULE__{}

  @doc """
  Return new queue structure

  Example:
          iex> Queue.new()
          #Queue<Empty>
  """
  @spec new :: Queue.t
  def new do
    queue = :queue.new()

    %__MODULE__{queue: queue}
  end

  @doc """
  Return the queue is empty

  Example:
        iex> queue = Queue.new()
        iex> Queue.empty?(queue)
        true
        iex> queue = Queue.inside(queue, 1)
        iex> Queue.empty?(queue)
        false
  """
  @spec empty?(Queue.t()) :: boolean()
  def empty?(%__MODULE__{queue: queue}) do
    :queue.is_empty(queue)
  end

  @doc """
  Put element in queue
  """
  @spec inside(Queue.t(), any()) :: any()
  def inside(%__MODULE__{queue: queue}, item) do
    queue = :queue.in(item, queue)

    %__MODULE__{queue: queue}
  end

  @doc """
  Get element of queue
  """
  @spec out(Queue.t()) :: any()
  def out(%__MODULE__{queue: queue}) do
    case :queue.out(queue) do
      {{:value, item}, queue} -> {item, %Queue{queue: queue}}
      {:empty, queue} -> {nil, %Queue{queue: queue}}
    end
  end
end
