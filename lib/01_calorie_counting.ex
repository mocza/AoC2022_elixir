defmodule CalorieCounting do
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
