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

  def day5_1(file) do
    stacks = %{}
    stacks = Map.put(stacks, 1, SupplyStacks.Stack.new(["P", "G", "R", "N"]))
    stacks = Map.put(stacks, 2, SupplyStacks.Stack.new(["C", "D", "G", "F", "L", "B", "T", "J"]))
    stacks = Map.put(stacks, 3, SupplyStacks.Stack.new(["V", "S", "M"]))
    stacks = Map.put(stacks, 4, SupplyStacks.Stack.new(["P", "Z", "C", "R", "S", "L"]))
    stacks = Map.put(stacks, 5, SupplyStacks.Stack.new(["Q", "D", "W", "C", "V", "L", "S", "P"]))
    stacks = Map.put(stacks, 6, SupplyStacks.Stack.new(["S", "M", "D", "W", "N", "T", "C"]))
    stacks = Map.put(stacks, 7, SupplyStacks.Stack.new(["P", "W", "G", "D", "H"]))
    stacks = Map.put(stacks, 8, SupplyStacks.Stack.new(["V", "M", "C", "S", "H", "P", "L", "Z"]))
    stacks = Map.put(stacks, 9, SupplyStacks.Stack.new(["Z", "G", "W", "L", "F", "P", "R"]))

    SupplyStacks.read_operations(file)
    |> Enum.map(&(SupplyStacks.parse(&1)))
    |> Enum.reduce(stacks, &(SupplyStacks.move(&2, &1)))
    |> Enum.sort(fn {key1, _val1}, {key2, _val2} -> key1 > key2 end)
    |> Enum.reduce([], fn {_, value}, acc -> [hd(value) | acc] end)
    |> Enum.join()
  end

  def day5_2(file) do
    stacks = %{}
    stacks = Map.put(stacks, 1, SupplyStacks.Stack.new(["P", "G", "R", "N"]))
    stacks = Map.put(stacks, 2, SupplyStacks.Stack.new(["C", "D", "G", "F", "L", "B", "T", "J"]))
    stacks = Map.put(stacks, 3, SupplyStacks.Stack.new(["V", "S", "M"]))
    stacks = Map.put(stacks, 4, SupplyStacks.Stack.new(["P", "Z", "C", "R", "S", "L"]))
    stacks = Map.put(stacks, 5, SupplyStacks.Stack.new(["Q", "D", "W", "C", "V", "L", "S", "P"]))
    stacks = Map.put(stacks, 6, SupplyStacks.Stack.new(["S", "M", "D", "W", "N", "T", "C"]))
    stacks = Map.put(stacks, 7, SupplyStacks.Stack.new(["P", "W", "G", "D", "H"]))
    stacks = Map.put(stacks, 8, SupplyStacks.Stack.new(["V", "M", "C", "S", "H", "P", "L", "Z"]))
    stacks = Map.put(stacks, 9, SupplyStacks.Stack.new(["Z", "G", "W", "L", "F", "P", "R"]))

    SupplyStacks.read_operations(file)
    |> Enum.map(&(SupplyStacks.parse(&1)))
    |> Enum.reduce(stacks, &(SupplyStacks.move2(&2, &1)))
    |> Enum.sort(fn {key1, _val1}, {key2, _val2} -> key1 > key2 end)
    |> Enum.reduce([], fn {_, value}, acc -> [hd(value) | acc] end)
    |> Enum.join()
  end


end
