defmodule TreetopTreehouse do

  def read(file) do
    String.split(File.read!(file), "\n")
  end

  def parse(lines) do
    for {line, row_id} <- Enum.with_index(lines, 1), reduce: %{} do
      rows ->
        row = for {tree_height, col_id} <- Enum.with_index(String.graphemes(line), 1), reduce: %{} do
          tree_heights -> Map.put(tree_heights, col_id, String.to_integer(tree_height))
        end
        Map.put(rows, row_id, row)
    end
  end

  def visible(grid) do
    for {row_id, row} <- grid, row_id > 1, row_id < map_size(grid), {col_id, _height} <- row, col_id > 1, col_id < map_size(row), reduce: [] do
        visible_trees ->
            if visible_horizontally(grid, row_id, col_id) or visible_vertically(grid, row_id, col_id) do
              visible_trees ++ [{row_id, col_id}]
            else
              visible_trees
            end
    end
  end

  def visible_horizontally(grid, row_id, col_id) do
    height = grid[row_id][col_id]
    hides_from_left = for {id, other_height} <- grid[row_id], id < col_id, other_height >= height, do: {row_id, id}
    hides_from_right = for {id, other_height} <- grid[row_id], id > col_id, other_height >= height, do: {row_id, id}
    if Enum.empty?(hides_from_left) or Enum.empty?(hides_from_right) do true else false end
  end

  def visible_vertically(grid, row_id, col_id) do
    height = grid[row_id][col_id]
    hides_from_up = for {i, row} <- grid, i < row_id, {j, other_height} <- row, j == col_id, other_height >= height, do: {i, j}
    hides_from_down = for {i, row} <- grid, i > row_id, {j, other_height} <- row, j == col_id, other_height >= height, do: {i, j}
    if Enum.empty?(hides_from_up) or Enum.empty?(hides_from_down) do true else false end
  end

  def visible_on_edge(grid) do
    map_size(grid) * 4 - 4
  end


  def scenic_score(grid) do
    for {row_id, row} <- grid, reduce: %{} do
      rows ->
        row = for {col_id, tree_height} <- row, reduce: %{} do
          tree_heights_with_score -> Map.put(tree_heights_with_score, col_id, %{height: tree_height, score: scenic_score(grid, row_id, col_id)})
        end
        Map.put(rows, row_id, row)
    end
  end

  def scenic_score(grid, row_id, col_id) do
    scenic_score_left(grid, row_id, col_id) * scenic_score_right(grid, row_id, col_id) * scenic_score_up(grid, row_id, col_id) * scenic_score_down(grid, row_id, col_id)
  end

  def scenic_score_right(grid, row_id, col_id) do
    height = grid[row_id][col_id]
    taller_trees_right = for {id, other_height} <- grid[row_id], id > col_id, other_height >= height, do: {row_id, id}
    taller_trees_right = Enum.sort_by(taller_trees_right, fn {_, col_id} -> col_id end)
    view_limiting_tree = case taller_trees_right do
      [] -> {row_id, map_size(grid[row_id])}
      [head | _] -> head
    end
    {_, view_limit_pos} = view_limiting_tree
    view_limit_pos - col_id
  end

  def scenic_score_left(grid, row_id, col_id) do
    height = grid[row_id][col_id]
    taller_trees_left = for {id, other_height} <- grid[row_id], id < col_id, other_height >= height, do: {row_id, id}
    taller_trees_left = Enum.sort_by(taller_trees_left, fn {_, col_id} -> -col_id end)
    view_limiting_tree = case taller_trees_left do
      [] -> {row_id, 1}
      [head | _] -> head
    end
    {_, view_limit_pos} = view_limiting_tree
    col_id - view_limit_pos
  end

  def scenic_score_down(grid, row_id, col_id) do
    height = grid[row_id][col_id]
    taller_trees_down = for {i, row} <- grid, i > row_id, {j, other_height} <- row, j == col_id, other_height >= height, do: {i, j}
    taller_trees_down = Enum.sort_by(taller_trees_down, fn {row_id, _} -> row_id end)
    view_limiting_tree = case taller_trees_down do
      [] -> {map_size(grid), col_id}
      [head | _] -> head
    end
    {view_limit_pos, _} = view_limiting_tree
    view_limit_pos - row_id
  end

  def scenic_score_up(grid, row_id, col_id) do
    height = grid[row_id][col_id]
    taller_trees_up = for {i, row} <- grid, i < row_id, {j, other_height} <- row, j == col_id, other_height >= height, do: {i, j}
    taller_trees_up = Enum.sort_by(taller_trees_up, fn {row_id, _} -> -row_id end)
    view_limiting_tree = case taller_trees_up do
      [] -> {1, col_id}
      [head | _] -> head
    end
    {view_limit_pos, _} = view_limiting_tree
    row_id - view_limit_pos
  end



end
