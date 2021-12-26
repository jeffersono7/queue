defimpl Inspect, for: Queue do
  def inspect(queue, opts) do
    if Queue.empty?(queue), do: "#Queue<Empty>", else: compile_inspect(queue, opts)
  end

  defp compile_inspect(%Queue{queue: queue}, _opts) do
    head = :queue.head(queue)
    last = :queue.last(queue)
    len = :queue.len(queue)

    if len === 1, do: "#Queue<1>", else: "#Queue<#{head}...:#{last}>"
  end
end
