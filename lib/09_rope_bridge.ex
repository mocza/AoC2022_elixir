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
    start = [{{1, 1}, {1, 1}}]
    for {direction, steps} <- input, reduce: start do
      acc -> move(acc, direction, steps) ++ acc
    end
  end

  def move(moves, direction, steps) do
    case moves do
      [last | _rest] ->
        # {{hx, hy}, {tx, ty}} = last
        # [{{hx, hy + 1}, {tx, ty}}] ++ moves
        if steps > 0 do
          for _count <- 1..steps, reduce: moves do
            acc ->
              # {{hx, hy}, {tx, ty}} = hd(acc)
              # [{{hx, hy + 1}, {tx, if hy - ty > 0 do ty + 1 else ty end}}] ++ acc
              [move(hd(acc), direction)] ++ acc
          end
        else
          moves
        end
    end
  end

  def move(last, direction) do
    {{hx, hy}, _} = last
    case direction do
      "R" ->
        move_head = &({&1, &2 + 1})
        {move_head.(hx, hy), move_tail(last, move_head)}
      "L" ->
        move_head = &({&1, &2 - 1})
        {move_head.(hx, hy), move_tail(last, move_head)}
      "U" ->
        move_head = &({&1 + 1, &2})
        {move_head.(hx, hy), move_tail(last, move_head)}
      "D" ->
        move_head = &({&1 - 1, &2})
        {move_head.(hx, hy), move_tail(last, move_head)}
    end
  end

  def move_tail(last, fun) do
      {last_head, last_tail} = last
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
      # if distance(new_head, last_tail) > 1  do fun.(elem(last_tail, 0), elem(last_tail, 1)) else last_tail end

  end

  def distance(head, tail) do
    {hx, hy} = head
    {tx, ty} = tail
    {abs(hx - tx), abs(hy - ty)}
  end

end
