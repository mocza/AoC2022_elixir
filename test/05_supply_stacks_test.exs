defmodule SupplyStacksTest do
  use ExUnit.Case
  @stacks %{1 => ["P", "G", "R", "N"], 2 => ["C", "D", "G", "F", "L", "B", "T", "J"],
  3 => ["V", "M", "C", "S", "H", "P", "L", "Z", "O", "X"]}
  @stacks_input %{1 => ["P", "G", "R", "N"], 2 => ["C", "D", "G", "F", "L", "B", "T", "J"],
  3 => ["V", "S", "M"], 4 => ["P", "Z", "C", "R", "S", "L"],
  5 => ["Q", "D", "W", "C", "V", "L", "S", "P"], 6 => ["S", "M", "D", "W", "N", "T", "C"],
  7 => ["P", "W", "G", "D", "H"], 8 => ["V", "M", "C", "S", "H", "P", "L", "Z"],
  9 => ["Z", "G", "W", "L", "F", "P", "R"]}

  test "move" do
    assert SupplyStacks.move(@stacks, {1, 2}) == %{1 => ["G", "R", "N"], 2 => ["P", "C", "D", "G", "F", "L", "B", "T", "J"],
      3 => ["V", "M", "C", "S", "H", "P", "L", "Z", "O", "X"]}
    assert SupplyStacks.move(@stacks, {0, 1, 2}) == %{1 => ["P", "G", "R", "N"], 2 => ["C", "D", "G", "F", "L", "B", "T", "J"],
      3 => ["V", "M", "C", "S", "H", "P", "L", "Z", "O", "X"]}
    assert SupplyStacks.move(@stacks, {1, 1, 2}) == %{1 => ["G", "R", "N"], 2 => ["P", "C", "D", "G", "F", "L", "B", "T", "J"],
      3 => ["V", "M", "C", "S", "H", "P", "L", "Z", "O", "X"]}
    assert SupplyStacks.move(@stacks, {2, 1, 2}) == %{1 => ["R", "N"], 2 => ["G", "P", "C", "D", "G", "F", "L", "B", "T", "J"],
      3 => ["V", "M", "C", "S", "H", "P", "L", "Z", "O", "X"]}

    assert SupplyStacks.move(@stacks, {10, 3, 1}) == %{1 => ["X", "O", "Z", "L", "P", "H", "S", "C" ,"M", "V", "P", "G", "R", "N"],
      2 => ["C", "D", "G", "F", "L", "B", "T", "J"], 3 => []}

    assert SupplyStacks.move(@stacks_input, {2, 4, 6}) == %{1 => ["P", "G", "R", "N"], 2 => ["C", "D", "G", "F", "L", "B", "T", "J"],
    3 => ["V", "S", "M"], 4 => ["C", "R", "S", "L"],
    5 => ["Q", "D", "W", "C", "V", "L", "S", "P"], 6 => ["Z", "P", "S", "M", "D", "W", "N", "T", "C"],
    7 => ["P", "W", "G", "D", "H"], 8 => ["V", "M", "C", "S", "H", "P", "L", "Z"],
    9 => ["Z", "G", "W", "L", "F", "P", "R"]}
    assert SupplyStacks.move(@stacks_input, {2, 4, 6})
    |> SupplyStacks.move({4, 5, 3}) == %{1 => ["P", "G", "R", "N"], 2 => ["C", "D", "G", "F", "L", "B", "T", "J"],
    3 => [ "C","W","D", "Q", "V", "S", "M"], 4 => ["C", "R", "S", "L"],
    5 => ["V", "L", "S", "P"], 6 => ["Z", "P", "S", "M", "D", "W", "N", "T", "C"],
    7 => ["P", "W", "G", "D", "H"], 8 => ["V", "M", "C", "S", "H", "P", "L", "Z"],
    9 => ["Z", "G", "W", "L", "F", "P", "R"]}
    assert SupplyStacks.move(@stacks_input, {2, 4, 6})
    |> SupplyStacks.move({4, 5, 3})
    |> SupplyStacks.move({6, 6, 1}) == %{1 => ["W", "D", "M", "S", "P", "Z", "P", "G", "R", "N"], 2 => ["C", "D", "G", "F", "L", "B", "T", "J"],
    3 => [ "C","W","D", "Q", "V", "S", "M"], 4 => ["C", "R", "S", "L"],
    5 => ["V", "L", "S", "P"], 6 => ["N", "T", "C"],
    7 => ["P", "W", "G", "D", "H"], 8 => ["V", "M", "C", "S", "H", "P", "L", "Z"],
    9 => ["Z", "G", "W", "L", "F", "P", "R"]}
  end


  # test "read operations from file" do
  #   assert SupplyStacks.read("./test/05_input.txt") == {}
  # end

  # test "parse operation" do
  #   assert SupplyStacks.parse("move 5 from 1 to 10") == {5, 1, 10}
  # end

end
