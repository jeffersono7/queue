defmodule Queue.AgentTest do
  use ExUnit.Case

  alias Queue.Agent, as: QueueAgent

  describe "start_link/1" do
    test "Return pid" do
      {:ok, pid} = QueueAgent.start_link(nil)

      Process.alive?(pid)

      Process.exit(pid, :kill)
    end
  end

  describe "inside/1" do
    setup do
      QueueAgent.start_link(nil)

      :ok
    end

    test "When given item, put the item in queue" do
      :ok = QueueAgent.inside(1)

      assert 1 == QueueAgent.out()
    end
  end

  describe "out/0" do
    setup do
      QueueAgent.start_link(nil)

      :ok
    end

    test "When queue with items, return item" do
      QueueAgent.inside(1)

      assert 1 == QueueAgent.out()
    end

    test "When empty queue, return nil" do
      assert nil == QueueAgent.out()
    end
  end
end
