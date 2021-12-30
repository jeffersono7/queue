defimpl Enumerable, for: Queue do
  @spec count(Queue.t()) :: {:ok, non_neg_integer} | {:error, :not_is_queue}
  def count(%Queue{queue: queue}) do
    {:ok, :queue.len(queue)}
  end

  def count(_), do: {:error, :not_is_queue}

  @spec member?(Queue.t(), any) :: {:ok, boolean()} | {:error, atom()}
  def member?(%Queue{queue: queue}, element) do
    {:ok, :queue.member(element, queue)}
  end

  def member?(_, _), do: {:error, :not_is_queue}

  def reduce(%Queue{}, {:halt, acc}, _reduce_fun) do
    {:halted, acc}
  end

  def reduce(%Queue{} = queue, {:suspend, acc}, reduce_fun) do
    {:suspended, acc, &reduce(queue, &1, reduce_fun)}
  end

  def reduce(%Queue{} = queue, {:cont, acc}, reduce_fn) do
    if Queue.empty?(queue) do
      {:done, acc}
    else
      {element, queue} = Queue.out(queue)

      reduce(queue, reduce_fn.(element, acc), reduce_fn)
    end
  end

  def slice(%Queue{} = queue) do
    {:ok, Queue.count(queue), &slicing_fun(queue, 0, [], &1, &2)}
  end

  defp slicing_fun(%Queue{} = _queue, index, list, start, length) when index - start === length do
    list
  end

  defp slicing_fun(%Queue{} = queue, index, list, start, length) do
    {element, queue} = Queue.out(queue)

    case index >= start do
      true ->
        slicing_fun(queue, index + 1, list ++ [element], start, length)

      false ->
        slicing_fun(queue, index + 1, list, start, length)
    end
  end
end
