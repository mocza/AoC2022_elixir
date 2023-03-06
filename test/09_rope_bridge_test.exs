defmodule RopeBridgeTest do
  use ExUnit.Case
  @moves_input [{"R", 4}, {"U", 4}, {"L", 3}, {"D", 1}, {"R", 4}, {"D", 1}, {"L", 5}, {"R", 2}]
  @parse_input ["R 4", "U 4", "L 3", "D 1", "R 4", "D 1", "L 5", "R 2"]

  test "move right" do
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "R", 0) == [{{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "R", 1) == [{{1, 2}, {1, 1}}, {{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "R", 2) == [{{1, 3}, {1, 2}}, {{1, 2}, {1, 1}}, {{1, 1}, {1, 1}}]
  end

  test "move left" do
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "L", 0) == [{{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "L", 1) == [{{1, 0}, {1, 1}}, {{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "L", 2) == [{{1, -1}, {1, 0}}, {{1, 0}, {1, 1}}, {{1, 1}, {1, 1}}]
  end

  test "move up" do
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "U", 0) == [{{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "U", 1) == [{{2, 1}, {1, 1}}, {{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "U", 2) == [{{3, 1}, {2, 1}}, {{2, 1}, {1, 1}}, {{1, 1}, {1, 1}}]
  end

  test "move down" do
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "D", 0) == [{{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "D", 1) == [{{0, 1}, {1, 1}}, {{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "D", 2) == [{{-1, 1}, {0, 1}}, {{0, 1}, {1, 1}}, {{1, 1}, {1, 1}}]
  end

  test "move diagonally up and right" do
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "U", 1) |> RopeBridge.move("R", 1) == [{{2, 2}, {1, 1}}, {{2, 1}, {1, 1}}, {{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "U", 1) |> RopeBridge.move("R", 2) == [{{2, 3}, {2, 2}}, {{2, 2}, {1, 1}}, {{2, 1}, {1, 1}}, {{1, 1}, {1, 1}}]
  end

  test "move diagonally down and right" do
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "D", 1) |> RopeBridge.move("R", 1) == [{{0, 2}, {1, 1}}, {{0, 1}, {1, 1}}, {{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "D", 1) |> RopeBridge.move("R", 2) == [{{0, 3}, {0, 2}}, {{0, 2}, {1, 1}}, {{0, 1}, {1, 1}}, {{1, 1}, {1, 1}}]
  end

  test "move diagonally up and left" do
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "U", 1) |> RopeBridge.move("L", 1) == [{{2, 0}, {1, 1}}, {{2, 1}, {1, 1}}, {{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "U", 1) |> RopeBridge.move("L", 2) == [{{2, -1}, {2, 0}}, {{2, 0}, {1, 1}}, {{2, 1}, {1, 1}}, {{1, 1}, {1, 1}}]
  end

  test "move diagonally down and left" do
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "D", 1) |> RopeBridge.move("L", 1) == [{{0, 0}, {1, 1}}, {{0, 1}, {1, 1}}, {{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "D", 1) |> RopeBridge.move("L", 2) == [{{0, -1}, {0, 0}}, {{0, 0}, {1, 1}}, {{0, 1}, {1, 1}}, {{1, 1}, {1, 1}}]
  end

  test "input" do
    moves = RopeBridge.move(@moves_input)
    tail_move_counts = for {rh, rt} <- moves, reduce: %{} do
        acc -> if Map.get(acc, rt) == nil do Map.put(acc, rt, 1) else Map.put(acc, rt, Map.get(acc, rt) + 1) end
      end
    assert map_size(tail_move_counts) == 13
  end

  test "parse strings describing moves into list of tuples" do
    assert RopeBridge.parse(@parse_input) == [{"R", 4}, {"U", 4}, {"L", 3}, {"D", 1}, {"R", 4}, {"D", 1}, {"L", 5}, {"R", 2}]
  end

end
