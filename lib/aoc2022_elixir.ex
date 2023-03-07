defmodule Aoc2022Elixir do

  def day1_1(file) do
    CalorieCounting.read_calories(file)
    |> CalorieCounting.partition_calories()
    |> CalorieCounting.sum_calories()
    |> CalorieCounting.max_calories()
  end

  def day1_2(file) do
    CalorieCounting.read_calories(file)
    |> CalorieCounting.partition_calories()
    |> CalorieCounting.sum_calories()
    |> CalorieCounting.top_calories(3)
    |> Enum.sum()
  end

  def day2_1(file) do
    RockPaperScissors.read_encrypted(file)
    |> Enum.map(&(String.split(&1)))
    |> Enum.map(&(RockPaperScissors.decrypt1(&1)))
    |> Enum.map(&(RockPaperScissors.score(&1)))
    |> Enum.reduce(0, &(&1 + &2))
  end

  def day2_2(file) do
    RockPaperScissors.read_encrypted(file)
    |> Enum.map(&(String.split(&1)))
    |> Enum.map(&(RockPaperScissors.decrypt2(&1)))
    |> Enum.map(&(RockPaperScissors.how_to_play_for_outcome(&1)))
    |> Enum.map(&(RockPaperScissors.score(&1)))
    |> Enum.reduce(0, &(&1 + &2))
  end

  def day3_1(file) do
    RucksackReorganization.read(file)
    |> Enum.map(&(RucksackReorganization.compartments(&1)))
    |> RucksackReorganization.common_items([])
    |> RucksackReorganization.priority([])
    |> Enum.reduce(&(&1 + &2))
  end

  def day3_2(file) do
    RucksackReorganization.read(file)
    |> Enum.chunk_every(3)
    |> Enum.map(&(RucksackReorganization.find_badge(&1)))
    |> RucksackReorganization.priority([])
    |> Enum.reduce(&(&1 + &2))
  end

  def day4_1(file) do
    CampCleanup.read(file)
    |> Enum.map(&(String.split(&1, ",")))
    |> Enum.map(&(CampCleanup.fully_overlap?(&1)))
    |> Enum.count(&(&1 == true))
  end

  def day4_2(file) do
    CampCleanup.read(file)
    |> Enum.map(&(String.split(&1, ",")))
    |> Enum.map(&(CampCleanup.overlap?(&1)))
    |> Enum.count(&(&1 == true))
  end

  @day5_input %{1 => ["P", "G", "R", "N"], 2 => ["C", "D", "G", "F", "L", "B", "T", "J"],
  3 => ["V", "S", "M"], 4 => ["P", "Z", "C", "R", "S", "L"],
  5 => ["Q", "D", "W", "C", "V", "L", "S", "P"], 6 => ["S", "M", "D", "W", "N", "T", "C"],
  7 => ["P", "W", "G", "D", "H"], 8 => ["V", "M", "C", "S", "H", "P", "L", "Z"],
  9 => ["Z", "G", "W", "L", "F", "P", "R"]}

  def day5(file, move_fn) do
    SupplyStacks.read_operations(file)
    |> Enum.map(&(SupplyStacks.parse(&1)))
    |> Enum.reduce(@day5_input, fn operation, stack -> move_fn.(stack, operation) end)
    |> Enum.sort(fn {key1, _val1}, {key2, _val2} -> key1 > key2 end)
    |> Enum.reduce([], fn {_, value}, acc -> [hd(value) | acc] end)
    |> Enum.join()
  end
  def day5_1(file) do
    day5(file, &SupplyStacks.move/2)
  end

  def day5_2(file) do
    day5(file, &SupplyStacks.move2/2)
  end

  def day6_1(file) do
    TuningTrouble.read(file)
    |> TuningTrouble.marker_pos(:packet)
  end

  def day6_2(file) do
    TuningTrouble.read(file)
    |> TuningTrouble.marker_pos(:message)
  end

  def day7_1(file) do
    NoSpaceLeft.read(file)
    |> NoSpaceLeft.parse()
    |> NoSpaceLeft.size()
    |> Enum.filter(fn {_id, %{dir: dir, size: size}} -> dir == true && size < 100000 end)
    |> Enum.reduce(0, fn {_id, %{size: size}}, acc -> acc + size end)
  end

  def day7_2(file) do
    NoSpaceLeft.read(file)
    |> NoSpaceLeft.parse()
    |> NoSpaceLeft.size()
    |> NoSpaceLeft.smallest_dir_to_delete(30000000, 70000000)
  end

  def day8_1(file) do
    grid = TreetopTreehouse.read(file) |> TreetopTreehouse.parse()
    visible_in_interior = TreetopTreehouse.visible(grid) |> Enum.count()
    TreetopTreehouse.visible_on_edge(grid) + visible_in_interior
  end

  def day8_2(file) do
    top_score_tree = TreetopTreehouse.read(file)
    |> TreetopTreehouse.parse()
    |> TreetopTreehouse.scenic_score()
    # |> Map.values()
    # |> Enum.flat_map(&Map.values()/1)
    # |> Enum.map(& &1[:score])
    # |> Enum.max_by(& &1)
    |> Enum.flat_map(fn {row_id, row} -> row
    |> Enum.flat_map(fn {col_id, values} -> values
    |> Enum.map(fn {key, value} -> {{row_id, col_id, key}, value}
    end) end) end)
    |> Enum.filter(fn {{_, _, k}, _} -> k == :score end)
    |> Enum.max_by(fn {{_, _, _}, v} -> v end)
    {{_, _, _}, score} = top_score_tree
    score
  end

  def day9_1(file) do
    moves = RopeBridge.read(file)
    |> RopeBridge.parse()
    |> RopeBridge.move()
    for {key, _value} <- moves, key != :tail and key != :head, reduce: 0 do
      acc -> acc + 1
    end
    # File.stream!(file, :line)
    # |> Stream.each(&RopeBridge.parse_move/1)
    # |> Stream.run()
    # tail_move_counts = for {rh, rt} <- moves, reduce: %{} do
    #   acc -> if Map.get(acc, rt) == nil do Map.put(acc, rt, 1) else Map.put(acc, rt, Map.get(acc, rt) + 1) end
    # end
    # map_size(tail_move_counts)
  end


end
