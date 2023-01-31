defmodule Aoc2022ElixirTest do
  use ExUnit.Case
  doctest Aoc2022Elixir

  test "partition calories by elf" do
    assert Aoc2022Elixir.partition_calories(["1000", "2000", "", "4000"]) == [[1000, 2000], [4000]]
  end

  test "sum partitioned calories by elf" do
    assert Aoc2022Elixir.sum_calories([[1000, 2000], [4000]]) == [3000, 4000]
  end

  test "read calories by line from text file" do
    assert Aoc2022Elixir.read_calories("./test/calories01/oneBagOneItem.txt") == ["1000"]
    assert Aoc2022Elixir.read_calories("./test/calories01/oneBagTwoItems.txt") == ["1000", "2000"]
    assert Aoc2022Elixir.read_calories("./test/calories01/twoBagsTwoAndOneItem.txt") == ["1000", "2000", "", "4000"]
  end

  test "max calories" do
    assert Aoc2022Elixir.max_calories([1000, 2000, 3000]) == 3000
  end

end
