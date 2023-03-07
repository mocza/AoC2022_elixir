defmodule RopeBridgeTest do
  use ExUnit.Case
  @moves_input [{"R", 4}, {"U", 4}, {"L", 3}, {"D", 1}, {"R", 4}, {"D", 1}, {"L", 5}, {"R", 2}]
  @parse_input ["R 4", "U 4", "L 3", "D 1", "R 4", "D 1", "L 5", "R 2"]
  @start %{{1, 1} =>1, head: {1, 1}, tail: {1, 1}}

  test "move right" do
    assert RopeBridge.move(@start, "R", 0) == %{{1, 1} =>1, head: {1, 1}, tail: {1, 1}}
    assert RopeBridge.move(@start, "R", 1) == %{{1, 1} =>1, head: {1, 2}, tail: {1, 1}}
    assert RopeBridge.move(@start, "R", 2) == %{:head => {1, 3}, :tail => {1, 2}, {1, 1} => 1, {1, 2} => 1}
  end

  test "move left" do
    assert RopeBridge.move(@start, "L", 0) == %{{1, 1} =>1, head: {1, 1}, tail: {1, 1}}
    assert RopeBridge.move(@start, "L", 1) == %{:head => {1, 0}, :tail => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@start, "L", 2) == %{:head => {1, -1}, :tail => {1, 0}, {1, 1} => 1, {1, 0} => 1}
  end

  test "move up" do
    assert RopeBridge.move(@start, "U", 0) == %{{1, 1} =>1, head: {1, 1}, tail: {1, 1}}
    assert RopeBridge.move(@start, "U", 1) == %{:head => {2, 1}, :tail => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@start, "U", 2) ==  %{:head => {3, 1}, :tail => {2, 1}, {1, 1} => 1, {2, 1} => 1}
  end

  test "move down" do
    assert RopeBridge.move(@start, "D", 0) == %{{1, 1} =>1, head: {1, 1}, tail: {1, 1}}
    assert RopeBridge.move(@start, "D", 1) == %{:head => {0, 1}, :tail => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@start, "D", 2) == %{:head => {-1, 1}, :tail => {0, 1}, {0, 1} => 1, {1, 1} => 1}
  end

  test "move diagonally up and right" do
    assert RopeBridge.move(@start, "U", 1) |> RopeBridge.move("R", 1) == %{:head => {2, 2}, :tail => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@start, "U", 1) |> RopeBridge.move("R", 2) == %{:head => {2, 3}, :tail => {2, 2}, {1, 1} => 1, {2, 2} => 1}
  end

  test "move diagonally down and right" do
    assert RopeBridge.move(@start, "D", 1) |> RopeBridge.move("R", 1) == %{:head => {0, 2}, :tail => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@start, "D", 1) |> RopeBridge.move("R", 2) == %{:head => {0, 3}, :tail => {0, 2}, {0, 2} => 1, {1, 1} => 1}
  end

  test "move diagonally up and left" do
    assert RopeBridge.move(@start, "U", 1) |> RopeBridge.move("L", 1) == %{:head => {2, 0}, :tail => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@start, "U", 1) |> RopeBridge.move("L", 2) == %{:head => {2, -1}, :tail => {2, 0}, {1, 1} => 1, {2, 0} => 1}
  end

  test "move diagonally down and left" do
    assert RopeBridge.move(@start, "D", 1) |> RopeBridge.move("L", 1) == %{:head => {0, 0}, :tail => {1, 1}, {1, 1} => 1}
    assert RopeBridge.move(@start, "D", 1) |> RopeBridge.move("L", 2) == %{:head => {0, -1}, :tail => {0, 0}, {0, 0} => 1, {1, 1} => 1}
  end

  test "input" do
    count = for {key, value} <- RopeBridge.move(@moves_input), key != :tail and key != :head, reduce: 0 do
      acc -> acc + 1
    end
    assert count == 13
    # tail_move_counts = for {rh, rt} <- moves, reduce: %{} do
    #     acc -> if Map.get(acc, rt) == nil do Map.put(acc, rt, 1) else Map.put(acc, rt, Map.get(acc, rt) + 1) end
    #   end
    # assert map_size(tail_move_counts) == 13
  end

  # test "parse strings describing moves into list of tuples" do
  #   assert RopeBridge.parse(@parse_input) == [{"R", 4}, {"U", 4}, {"L", 3}, {"D", 1}, {"R", 4}, {"D", 1}, {"L", 5}, {"R", 2}]
  # end

end
