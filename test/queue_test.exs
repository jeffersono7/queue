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

      queue =
        Enum.reduce(items, Queue.new(), fn item, acc ->
          Queue.inside(acc, item)
        end)

      result = extract_all_items(queue, [])

      assert Enum.sort(items) == Enum.sort(result)
    end
  end

  describe "out/1" do
    test "When given queue, return first element and queue without it" do
      queue = Queue.new() |> Queue.inside(2) |> Queue.inside(1)

      assert {2, queue} = Queue.out(queue)
      assert {1, queue} = Queue.out(queue)
      assert {nil, ^queue} = Queue.out(queue)
    end
  end

  describe "head/1" do
    test "When given a queue, return the head element of queue" do
      queue = Queue.new() |> Queue.inside(1)

      assert 1 == Queue.head(queue)
    end

    test "When given empty queue, return nil" do
      result = Queue.new() |> Queue.head()

      assert nil == result
    end
  end

  describe "first/1" do
    test "When given a queue, return the first element of queue" do
      queue = Queue.new() |> Queue.inside(1)

      assert 1 == Queue.first(queue)
    end

    test "When given a empty queue, return nil" do
      result = Queue.new() |> Queue.first()

      assert nil == result
    end
  end

  describe "last/1" do
    test "When given a queue, return the last element of queue" do
      queue1 = Queue.new() |> Queue.inside(1)
      queue2 = queue1 |> Queue.inside(2)

      assert 1 == Queue.last(queue1)
      assert 2 == Queue.last(queue2)
    end

    test "When given a empty queue, return nil value" do
      assert nil == Queue.new() |> Queue.last()
    end
  end

  describe "to_list/1" do
    test "When given queue, retuns the values of queue" do
      queue = Queue.new() |> Queue.inside("first") |> Queue.inside("second")

      assert ["first", "second"] == Queue.to_list(queue)
    end

    test "When given empty queue, returns the empty list of queue values" do
      assert [] = Queue.new() |> Queue.to_list()
    end
  end

  describe "values/1" do
    test "When given queue, retuns the values of queue" do
      queue = Queue.new() |> Queue.inside("first") |> Queue.inside("second")

      assert ["first", "second"] == Queue.values(queue)
    end

    test "When given empty queue, returns the empty list of queue values" do
      assert [] = Queue.new() |> Queue.values()
    end
  end

  describe "count/1" do
    test "When given queue, return the length of queue" do
      assert 2 = Queue.new() |> Queue.inside(1) |> Queue.inside(2) |> Queue.count()
      assert 0 = Queue.new() |> Queue.count()
    end
  end

  defp extract_all_items(queue, acc) do
    case Queue.empty?(queue) do
      true ->
        acc

      false ->
        {item, queue_after} = Queue.out(queue)
        extract_all_items(queue_after, [item] ++ acc)
    end
  end
end
