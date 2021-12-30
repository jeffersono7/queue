defmodule QueueEnumerableTest do
  use ExUnit.Case, async: true

  describe "count/1" do
    test "Given a queue, count elements of queue" do
      queue = Queue.new() |> Queue.inside(1) |> Queue.inside(2) |> Queue.inside(3)

      assert 3 == Enum.count(queue)
    end

    test "Given a empty queue, count 0 elements of queue" do
      assert 0 == Queue.new() |> Enum.count()
    end
  end

  describe "member?/1" do
    test "Given a queue, returns if the element is member from queue" do
      queue = Queue.new() |> Queue.inside("element")

      assert true == Enum.member?(queue, "element")
      assert false == Enum.member?(queue, 1)
    end
  end

  describe "reduce/3" do
    test "Given a queue, reduce elements of queue" do
      queue = Queue.new() |> Queue.inside(1) |> Queue.inside(10) |> Queue.inside(7)

      assert 18 == Enum.reduce(queue, fn elem, acc -> elem + acc end)

      assert 0 == Queue.new() |> Enum.reduce(0, fn elem, acc -> elem + acc end)
    end
  end

  describe "slicing" do
    test "Given a queue, return slice queue" do
      queue =
        Queue.new()
        |> Queue.inside(1)
        |> Queue.inside(2)
        |> Queue.inside(3)
        |> Queue.inside(4)

      assert [1] == Enum.slice(queue, 0, 1)
      assert [2,3] == Enum.slice(queue, 1, 2)
      assert [] == Enum.slice(queue, 0, 0)
      assert [] == Enum.slice(queue, 10, 10)
      assert [1] == Enum.slice(queue, 0..0)
    end
  end
end
