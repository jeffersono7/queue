defmodule Queue do
  @moduledoc """
  Functions for work with erlang queue.
  """

  @keys [:queue]

  @enforce_keys @keys
  defstruct @keys

  @type t :: %__MODULE__{}

  @spec new :: Queue.t
  def new do
    queue = :queue.new()

    %__MODULE__{queue: queue}
  end

  @spec empty?(Queue.t()) :: boolean()
  def empty?(%__MODULE__{queue: queue}) do
    :queue.is_empty(queue)
  end

  @spec inside(Queue.t(), any()) :: any()
  def inside(%__MODULE__{queue: queue}, item) do
    queue = :queue.in(item, queue)

    %__MODULE__{queue: queue}
  end

  @spec out(Queue.t()) :: any()
  def out(%__MODULE__{queue: queue}) do
    case :queue.out(queue) do
      {{:value, item}, queue} -> {item, %Queue{queue: queue}}
      {:empty, queue} -> {nil, %Queue{queue: queue}}
    end
  end
end
