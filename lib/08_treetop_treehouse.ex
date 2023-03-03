defmodule TreetopTreehouse do

  def read(file) do
    String.split(File.read!(file), "\n")
  end

  def parse(lines) do
    for {line, row_id} <- Enum.with_index(lines, 1), reduce: %{} do
      rows ->
        row = for {tree_height, col_id} <- Enum.with_index(String.graphemes(line), 1), reduce: %{} do
          tree_heights ->
            Map.put(tree_heights, col_id, tree_height)
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
    # IO.inspect(binding())
    if Enum.empty?(hides_from_left) or Enum.empty?(hides_from_right) do true else false end
  end

  def visible_vertically(grid, row_id, col_id) do
    height = grid[row_id][col_id]
    hides_from_up = for {i, row} <- grid, i < row_id, {j, other_height} <- row, j == col_id, other_height >= height, do: {i, j}
    hides_from_down = for {i, row} <- grid, i > row_id, {j, other_height} <- row, j == col_id, other_height >= height, do: {i, j}
    # IO.inspect(binding())
    if Enum.empty?(hides_from_up) or Enum.empty?(hides_from_down) do true else false end
  end

  def visible_on_edge(grid) do
    map_size(grid) * 4 - 4
  end


end
