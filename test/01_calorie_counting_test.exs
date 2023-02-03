defmodule CalorieCountingTest do
  use ExUnit.Case
  doctest CalorieCounting

  test "partition calories by elf" do
    assert CalorieCounting.partition_calories(["1000", "2000", "", "4000"]) == [[1000, 2000], [4000]]
  end

  test "sum partitioned calories by elf" do
    assert CalorieCounting.sum_calories([[1000, 2000], [4000]]) == [3000, 4000]
  end

  test "max calories" do
    assert CalorieCounting.max_calories([1000, 2000, 3000]) == 3000
  end

end
