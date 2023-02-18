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
    assert Aoc2022Elixir.day4_1("./test/04_input.txt") == 562
    assert Aoc2022Elixir.day4_2("./test/04_input.txt") == 924
    assert Aoc2022Elixir.day5_1("./test/05_input.txt") == "VPCDMSLWJ"
    assert Aoc2022Elixir.day5_2("./test/05_input.txt") == "TPWCGNCCG"
    assert Aoc2022Elixir.day6_1("./test/06_input.txt") == 1100
    assert Aoc2022Elixir.day6_2("./test/06_input.txt") == 2421
  end



end
