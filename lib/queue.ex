defmodule Queue do
  @moduledoc """
  Module for work queue.

  This module implement protocol Enumerable.
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
  @spec new :: Queue.t()
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

  Example:

      iex> queue = Queue.new() |> Queue.inside(1)
      #Queue<1>
      iex> {1, queue} = Queue.out(queue)
      iex> queue
      #Queue<Empty>
  """
  @spec inside(Queue.t(), any()) :: any()
  def inside(%__MODULE__{queue: queue}, item) do
    queue = :queue.in(item, queue)

    %__MODULE__{queue: queue}
  end

  @doc """
  Get element of queue

  Example:

      iex> queue = Queue.new() |> Queue.inside(1)
      #Queue<1>
      iex> {1, queue} = Queue.out(queue)
      iex> queue
      #Queue<Empty>
      iex> {nil, ^queue} = Queue.out(queue)
  """
  @spec out(Queue.t()) :: any()
  def out(%__MODULE__{queue: queue}) do
    case :queue.out(queue) do
      {{:value, item}, queue} -> {item, %Queue{queue: queue}}
      {:empty, queue} -> {nil, %Queue{queue: queue}}
    end
  end

  @doc """
  Get head element of queue

  Example:

      iex> queue = Queue.new() |> Queue.inside(1)
      iex> Queue.head(queue)
      1
      iex> Queue.new() |> Queue.head()
      nil
  """
  @spec head(Queue.t()) :: any()
  def head(%__MODULE__{queue: queue}) do
    try do
      :queue.head(queue)
    rescue
      ErlangError -> nil
    end
  end

  @doc """
  Get first element of queue.

  This function is equals head function.

  Example:

      iex> queue = Queue.new() |> Queue.inside(1)
      iex> Queue.first(queue)
      1
      iex> Queue.new() |> Queue.first()
      nil
  """
  @spec first(Queue.t()) :: any()
  def first(queue) do
    head(queue)
  end

  @doc """
  Get last element of queue.

  Example:

      iex> queue = Queue.new() |> Queue.inside(1)
      iex> Queue.last(queue)
      1
      iex> queue = Queue.inside(queue, 2)
      iex> Queue.last(queue)
      2
      iex> Queue.new() |> Queue.last()
      nil
  """
  @spec last(Queue.t()) :: any()
  def last(%Queue{queue: queue}) do
    try do
      :queue.last(queue)
    rescue
      ErlangError -> nil
    end
  end

  @doc """
  Return a list with all values of queue.

  Examples:

      iex> queue = Queue.new() |> Queue.inside(1) |> Queue.inside(2)
      iex> Queue.to_list(queue)
      [1, 2]
  """
  @spec to_list(Queue.t()) :: list()
  def to_list(%Queue{queue: queue}), do: :queue.to_list(queue)
end
