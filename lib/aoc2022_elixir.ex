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
    |> Enum.map(&(RockPaperScissors.score2(&1)))
    |> Enum.reduce(0, &(&1 + &2))
  end


end
