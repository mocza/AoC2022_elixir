defmodule SupplyStacks do
  defmodule Stack do
    def new(items) do
      items
    end

    def new do
      []
    end

    def push(stack, item) do
      [item | stack]
    end

    def pop(stack) do
      case stack do
        [] -> {:error, :empty_stack}
        [_head | tail] -> {:ok, tail}
      end
    end

    def top(stack) do
      case stack do
        [] -> {:error, :empty_stack}
        [head | _tail] -> {:ok, head}
      end
    end
  end

  def move(stacks, {from, to}) do
    {:ok, top} = Stack.top(Map.get(stacks, from))
    stacks = Map.put(stacks, to, Stack.push(Map.get(stacks, to), top))
    {:ok, pop} = Stack.pop(Map.get(stacks, from))
    stacks = Map.put(stacks, from, pop)
    IO.inspect("from: " <> to_string(from) <> " to: " <> to_string(to) <> " stacks[4]: " <>  to_string(Map.get(stacks, 4)))
    # IO.puts("After: " <> IO.inspect(stacks))
    stacks
  end

  def move(stacks, {count, from, to}) do
    # IO.inspect("count: " <> to_string(count))
    case count do
      0 -> stacks
      1 -> move(stacks, {from, to})
      _ ->
        move(stacks, {from, to})
        |> move({count - 1, from, to})
    end
  end

  def read_operations(file) do
    Enum.filter(String.split(File.read!(file), "\n"), &(hd(String.split(&1, " ")) == "move" ))
  end

  def parse(operation_string) do
    [operation, count, _keyword_from, from, _keyword_to, to] = String.split(operation_string, " ")
    case operation do
      "move" ->
        # IO.puts(operation_string)
        {String.to_integer(count), String.to_integer(from), String.to_integer(to)}
    end
  end


end
