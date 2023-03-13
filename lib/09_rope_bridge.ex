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

  def move_rope(input, knot_count) do
    # IO.inspect(binding())
    start = initial_state(knot_count)
    for {direction, steps} <- input, reduce: start do
      acc -> move(acc, direction, steps)
    end
  end

  defp initial_state(knot_count) do
    for knot_id <- 0..knot_count-1, into: %{{1, 1} => 1}, do: {knot_id, {1, 1}}
  end

  def move(moves, direction, steps) do
    case steps do
      0 -> moves
      _ ->
        head_id = 0
        tail_id = 1
        {new_head, new_tail} = new_position(moves[head_id], moves[tail_id], direction)
        tail = moves[tail_id]
        moves
        |> Map.put(head_id, new_head)
        |> Map.update(new_tail, 1, fn value -> if new_tail != tail do value + 1 else value end end)
        |> Map.put(tail_id, new_tail)
        |> move(direction, steps - 1)
    end
  end

  def move(moves, direction) do
    # {new_head, new_tail} = new_position(moves[:head], moves[:tail], direction)
    # tail = moves[:tail]
    # moves
    # |> Map.put(:head, new_head)
    # |> Map.update(new_tail, 1, fn value -> if new_tail != tail do value + 1 else value end end)
    # |> Map.put(:tail, new_tail)
    # |> move(direction, steps - 1)
  end

  defp new_position(head, tail, direction) do
    {hx, hy} = head
    case direction do
      "R" ->
        move_head = &({&1, &2 + 1})
        {move_head.(hx, hy), move_tail(head, tail, move_head)}
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
