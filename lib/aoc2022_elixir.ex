defmodule Aoc2022Elixir do

  def solution1_1 do
    read_calories("./test/calories01/input.txt")
    |> partition_calories()
    |> sum_calories()
    |> max_calories()
  end

  def solution1_2 do
    read_calories("./test/calories01/input.txt")
    |> partition_calories()
    |> sum_calories()
    |> top_calories(3)
    |> Enum.sum()
  end

  def top_calories(list, n) do
    Enum.sort(list)
    |> Enum.reverse()
    |> Enum.take(n)
  end

  def max_calories(list) do
    Enum.max(list)
  end

  def sum_calories(list) do
    Enum.map(list, fn x -> Enum.sum(x) end)
  end

  def partition_calories(list) do
    Enum.reduce(list, [], fn x, acc ->
      case acc do
        [] -> [[String.to_integer(x)]]
        [sublist | rest] when x == "" -> [[]] ++ [sublist] ++ rest
        [sublist | rest] -> [[String.to_integer(x)] ++ sublist] ++ rest
      end
    end)
    |> Enum.map(fn x -> Enum.reverse(x) end)
    |> Enum.reverse()
  end

  def read_calories(filename) do
    String.split(File.read!(filename), "\n")
  end
end
