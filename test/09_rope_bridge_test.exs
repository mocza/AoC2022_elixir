defmodule RopeBridgeTest do
  use ExUnit.Case
  @moves_input [{"R", 4}, {"U", 4}, {"L", 3}, {"D", 1}, {"R", 4}, {"D", 1}, {"L", 5}, {"R", 2}]
  @parse_input ["R 4", "U 4", "L 3", "D 1", "R 4", "D 1", "L 5", "R 2"]
  @init_state %{visits: %{{1, 1} => 1}, knots: %{0 => {1, 1}, 1 => {1, 1}}}

  test "move right" do
    assert RopeBridge.move(@init_state, "R", 0) == %{knots: %{0 => {1, 1}, 1 => {1, 1}}, visits: %{{1, 1} => 1}}
    assert RopeBridge.move(@init_state, "R", 1) ==  %{knots: %{0 => {2, 1}, 1 => {1, 1}}, visits: %{{1, 1} => 1}}
    assert RopeBridge.move(@init_state, "R", 2) == %{knots: %{0 => {3, 1}, 1 => {2, 1}}, visits: %{{1, 1} => 1, {2, 1} => 1}}
  end

  test "move left" do
    assert RopeBridge.move(@init_state, "L", 0) == %{knots: %{0 => {1, 1}, 1 => {1, 1}}, visits: %{{1, 1} => 1}}
    assert RopeBridge.move(@init_state, "L", 1) == %{knots: %{0 => {0, 1}, 1 => {1, 1}}, visits: %{{1, 1} => 1}}
    assert RopeBridge.move(@init_state, "L", 2) == %{knots: %{0 => {-1, 1}, 1 => {0, 1}}, visits: %{{0, 1} => 1, {1, 1} => 1}}
  end

  test "move up" do
    assert RopeBridge.move(@init_state, "U", 0) == %{knots: %{0 => {1, 1}, 1 => {1, 1}}, visits: %{{1, 1} => 1}}
    assert RopeBridge.move(@init_state, "U", 1) == %{knots: %{0 => {1, 2}, 1 => {1, 1}}, visits: %{{1, 1} => 1}}
    assert RopeBridge.move(@init_state, "U", 2) == %{knots: %{0 => {1, 3}, 1 => {1, 2}}, visits: %{{1, 1} => 1, {1, 2} => 1}}
  end

  test "move down" do
    assert RopeBridge.move(@init_state, "D", 0) == %{knots: %{0 => {1, 1}, 1 => {1, 1}}, visits: %{{1, 1} => 1}}
    assert RopeBridge.move(@init_state, "D", 1) == %{knots: %{0 => {1, 0}, 1 => {1, 1}}, visits: %{{1, 1} => 1}}
    assert RopeBridge.move(@init_state, "D", 2) == %{knots: %{0 => {1, -1}, 1 => {1, 0}}, visits: %{{1, 0} => 1, {1, 1} => 1}}
  end

  test "move diagonally up and right" do
    assert RopeBridge.move(@init_state, "U", 1) |> RopeBridge.move("R", 1) == %{knots: %{0 => {2, 2}, 1 => {1, 1}}, visits: %{{1, 1} => 1}}
    assert RopeBridge.move(@init_state, "U", 1) |> RopeBridge.move("R", 2) == %{knots: %{0 => {3, 2}, 1 => {2, 2}}, visits: %{{1, 1} => 1, {2, 2} => 1}}
  end

  test "move diagonally down and right" do
    assert RopeBridge.move(@init_state, "D", 1) |> RopeBridge.move("R", 1) == %{knots: %{0 => {2, 0}, 1 => {1, 1}}, visits: %{{1, 1} => 1}}
    assert RopeBridge.move(@init_state, "D", 1) |> RopeBridge.move("R", 2) == %{knots: %{0 => {3, 0}, 1 => {2, 0}}, visits: %{{1, 1} => 1, {2, 0} => 1}}
  end

  test "move diagonally up and left" do
    assert RopeBridge.move(@init_state, "U", 1) |> RopeBridge.move("L", 1) == %{knots: %{0 => {0, 2}, 1 => {1, 1}}, visits: %{{1, 1} => 1}}
    assert RopeBridge.move(@init_state, "U", 1) |> RopeBridge.move("L", 2) == %{knots: %{0 => {-1, 2}, 1 => {0, 2}}, visits: %{{0, 2} => 1, {1, 1} => 1}}
  end

  test "move diagonally down and left" do
    assert RopeBridge.move(@init_state, "D", 1) |> RopeBridge.move("L", 1) == %{knots: %{0 => {0, 0}, 1 => {1, 1}}, visits: %{{1, 1} => 1}}
    assert RopeBridge.move(@init_state, "D", 1) |> RopeBridge.move("L", 2) == %{knots: %{0 => {-1, 0}, 1 => {0, 0}}, visits: %{{0, 0} => 1, {1, 1} => 1}}
  end

  test "input" do
    assert map_size(RopeBridge.move(@moves_input, 2)[:visits]) == 13
  end

  test "parse strings describing moves into list of tuples" do
    assert RopeBridge.parse(@parse_input) == [{"R", 4}, {"U", 4}, {"L", 3}, {"D", 1}, {"R", 4}, {"D", 1}, {"L", 5}, {"R", 2}]
  end

end
