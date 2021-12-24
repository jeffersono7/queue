# Queue

**Queue wrapper of erlang queue**

## Installation

The package can be installed
by adding `queue` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:queue, "~> 0.1.0"}
  ]
end
```

## Usage

### Queue module
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

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/queue](https://hexdocs.pm/queue).

