# Queue

**Modules to work with queue**

## Installation

The package can be installed
by adding `queue` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:queue_tool, "~> 0.1.2"}
  ]
end
```

## Usage

### Queue module

*This module implements Enumerable protocol.*

``` elixir
queue = Queue.new()
#Queue<Empty>

iex> queue = Queue.inside(queue, 1)

iex> 1 == Queue.out(queue)
true
```

### Queue agent module
``` elixir
iex> Queue.Agent.start_link(nil)
iex> Queue.Agent.inside(1)
iex> out = Queue.Agent.out()
iex> out == 1
true
```
[https://hexdocs.pm/queue](https://hexdocs.pm/queue_tool).

