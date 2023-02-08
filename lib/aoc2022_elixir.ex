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


end
