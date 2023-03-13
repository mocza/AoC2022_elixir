defmodule RopeBridgeTest do
  use ExUnit.Case
  @moves_input [{"R", 4}, {"U", 4}, {"L", 3}, {"D", 1}, {"R", 4}, {"D", 1}, {"L", 5}, {"R", 2}]
  @parse_input ["R 4", "U 4", "L 3", "D 1", "R 4", "D 1", "L 5", "R 2"]
  @init_state %{{1, 1} =>1, 0 => {1, 1}, 1 => {1, 1}}

  # test "move rope with n knots" do
  #   assert RopeBridge.move(@moves_input, 10) == %{0 => {1, 1}, 1 => {1, 1}, {1, 1} => 1}
  # end

  test "move right" do
    assert RopeBridge.move(@init_state, "R", 0) == %{{1, 1} =>1, 0 => {1, 1}, 1 => {1, 1}}
    assert RopeBridge.move(@init_state, "R", 1) == %{{1, 1} =>1, 0 => {1, 2}, 1 => {1, 1}}
    assert RopeBridge.move(@init_state, "R", 2) == %{0 => {1, 3}, 1 => {1, 2}, {1, 1} => 1, {1, 2} => 1}
  end

  test "move left" do
    assert RopeBridge.move(@init_state, "L", 0) == %{{1, 1} =>1, 0 => {1, 1}, 1 => {1, 1}}
    assert RopeBridge.move(@init_state, "L", 1) == %{0 => {1, 0}, 1 => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@init_state, "L", 2) == %{0 => {1, -1}, 1 => {1, 0}, {1, 1} => 1, {1, 0} => 1}
  end

  test "move up" do
    assert RopeBridge.move(@init_state, "U", 0) == %{{1, 1} =>1, 0 => {1, 1}, 1 => {1, 1}}
    assert RopeBridge.move(@init_state, "U", 1) == %{0 => {2, 1}, 1 => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@init_state, "U", 2) ==  %{0 => {3, 1}, 1 => {2, 1}, {1, 1} => 1, {2, 1} => 1}
  end

  test "move down" do
    assert RopeBridge.move(@init_state, "D", 0) == %{{1, 1} =>1, 0 => {1, 1}, 1 => {1, 1}}
    assert RopeBridge.move(@init_state, "D", 1) == %{0 => {0, 1}, 1 => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@init_state, "D", 2) == %{0 => {-1, 1}, 1 => {0, 1}, {0, 1} => 1, {1, 1} => 1}
  end

  test "move diagonally up and right" do
    assert RopeBridge.move(@init_state, "U", 1) |> RopeBridge.move("R", 1) == %{0 => {2, 2}, 1 => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@init_state, "U", 1) |> RopeBridge.move("R", 2) == %{0 => {2, 3}, 1 => {2, 2}, {1, 1} => 1, {2, 2} => 1}
  end

  test "move diagonally down and right" do
    assert RopeBridge.move(@init_state, "D", 1) |> RopeBridge.move("R", 1) == %{0 => {0, 2}, 1 => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@init_state, "D", 1) |> RopeBridge.move("R", 2) == %{0 => {0, 3}, 1 => {0, 2}, {0, 2} => 1, {1, 1} => 1}
  end

  test "move diagonally up and left" do
    assert RopeBridge.move(@init_state, "U", 1) |> RopeBridge.move("L", 1) == %{0 => {2, 0}, 1 => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@init_state, "U", 1) |> RopeBridge.move("L", 2) == %{0 => {2, -1}, 1 => {2, 0}, {1, 1} => 1, {2, 0} => 1}
  end

  test "move diagonally down and left" do
    assert RopeBridge.move(@init_state, "D", 1) |> RopeBridge.move("L", 1) == %{0 => {0, 0}, 1 => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@init_state, "D", 1) |> RopeBridge.move("L", 2) == %{0 => {0, -1}, 1 => {0, 0}, {0, 0} => 1, {1, 1} => 1}
  end

  test "input" do
    # count = for {key, value} <- RopeBridge.move_rope(@moves_input, 2), key != 0 and key != 1, reduce: 0 do
    #   acc -> acc + 1
    # end
    # assert count == 13

    assert map_size(RopeBridge.move_rope(@moves_input, 2)) - 2 == 13
  end

  test "parse strings describing moves into list of tuples" do
    assert RopeBridge.parse(@parse_input) == [{"R", 4}, {"U", 4}, {"L", 3}, {"D", 1}, {"R", 4}, {"D", 1}, {"L", 5}, {"R", 2}]
  end

end
