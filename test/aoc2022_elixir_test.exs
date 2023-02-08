defmodule Aoc2022ElixirTest do
  use ExUnit.Case
  doctest Aoc2022Elixir

  test "solutions" do
    assert Aoc2022Elixir.day1_1("./test/01_input.txt") == 68787
    assert Aoc2022Elixir.day1_2("./test/01_input.txt") == 198041
    assert Aoc2022Elixir.day2_1("./test/02_input.txt") == 10310
    assert Aoc2022Elixir.day2_2("./test/02_input.txt") == 14859
    assert Aoc2022Elixir.day3_1("./test/03_input.txt") == 7845
    assert Aoc2022Elixir.day3_2("./test/03_input.txt") == 2790
  end



end
