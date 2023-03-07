defmodule RopeBridge do

  def read(file) do
    File.read!(file)
    |> String.split("\n")
  end

  def parse(lines) do
    lines |> Enum.map(&parse_move/1)
  end

  def parse_move(line) do
    [direction, steps] = String.split(line, " ")
    {direction, String.to_integer(steps)}
  end

  def move(input) do
    # IO.inspect(binding())
    start = %{{1, 1} =>1, head: {1, 1}, tail: {1, 1}}
    for {direction, steps} <- input, reduce: start do
      acc -> move(acc, direction, steps)
    end
  end

  def move(moves, direction, steps) do
    case steps do
      0 -> moves
      _ ->
        {new_head, new_tail} = new_position(moves[:head], moves[:tail], direction)
        tail = moves[:tail]
        moves
        |> Map.put(:head, new_head)
        |> Map.update(new_tail, 1, fn value -> if new_tail != tail do value + 1 else value end end)
        |> Map.put(:tail, new_tail)
        |> move(direction, steps - 1)
    end
  end

  def move_loop(positions, direction, steps) do
    if steps > 0 do
      for _count <- 1..steps, reduce: positions do
        acc ->
          {new_head, new_tail} = new_position(acc[:head], acc[:tail], direction)
          acc = Map.put(acc, :head, new_head)
          tail = acc[:tail]
          acc = case new_tail do
            ^tail -> acc
            _ -> Map.update(acc, new_tail, 1, &(&1 + 1))
          end
          Map.put(acc, :tail, new_tail)
      end
    else
      positions
    end
  end

  defp new_position(head, tail, direction) do
    {hx, hy} = head
    case direction do
      "R" ->
        move_head = &({&1, &2 + 1})
        ret = {move_head.(hx, hy), move_tail(head, tail, move_head)}
        # IO.inspect(binding())
        ret
      "L" ->
        move_head = &({&1, &2 - 1})
        {move_head.(hx, hy), move_tail(head, tail, move_head)}
      "U" ->
        move_head = &({&1 + 1, &2})
        {move_head.(hx, hy), move_tail(head, tail, move_head)}
      "D" ->
        move_head = &({&1 - 1, &2})
        {move_head.(hx, hy), move_tail(head, tail, move_head)}
    end
  end

  def move_tail(last_head, last_tail, fun) do
      new_head = fun.(elem(last_head, 0), elem(last_head, 1))
      {distance_x, distance_y} = distance(new_head, last_tail)
      # IO.inspect(binding())
      cond do
        distance_x == 1 and distance_y == 2 -> fun.(elem(new_head, 0), elem(last_tail, 1))
        distance_x == 2 and distance_y == 1 -> fun.(elem(last_tail, 0), elem(new_head, 1))
        distance_x == 0 and distance_y == 0 -> last_tail
        distance_x == 1 or distance_y == 1 -> last_tail
        distance_x == 2 or distance_y == 2 -> fun.(elem(last_tail, 0), elem(last_tail, 1))
      end
  end

  def distance(head, tail) do
    {hx, hy} = head
    {tx, ty} = tail
    {abs(hx - tx), abs(hy - ty)}
  end

end
