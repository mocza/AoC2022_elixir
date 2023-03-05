defmodule RopeBridge do

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
    end
  end

  def move_tail(last, fun) do
      {last_head, last_tail} = last
      new_head = fun.(elem(last_head, 0), elem(last_head, 1))
      if distance(new_head, last_tail) > 1 do fun.(elem(last_tail, 0), elem(last_tail, 1)) else last_tail end

  end

  def distance(head, tail) do
    {hx, hy} = head
    {tx, ty} = tail
    abs(hx - tx) + abs(hy - ty)
  end

end
