defmodule QueueTest do
  use ExUnit.Case
  doctest Queue

  describe "new/0" do
    test "Return new Queue" do
      assert %Queue{} = Queue.new()
    end
  end

  describe "empty?/1" do
    test "When empty queue, return true" do
      assert true == Queue.new() |> Queue.empty?()
    end

    test "When not empty queue, return false" do
      queue = Queue.new() |> Queue.inside(1)

      assert false == Queue.empty?(queue)
    end
  end

  describe "inside/2" do
    test "When given item, return queue with item" do
      item = "item"

      queue = Queue.new() |> Queue.inside(item)

      assert {^item, _} = Queue.out(queue)
    end

    test "When given many items, return queue with all items" do
      items = 1..1_000 |> Enum.map(& &1)

      queue = Enum.reduce(items, Queue.new(), fn item, acc ->
        Queue.inside(acc, item)
      end)

      result = extract_all_items(queue, [])

      assert Enum.sort(items) == Enum.sort(result)
    end
  end

  defp extract_all_items(queue, acc) do
    case Queue.empty?(queue) do
      true -> acc
      false ->
        {item, queue_after} = Queue.out(queue)
        extract_all_items(queue_after, [item] ++ acc)
    end
  end
end
