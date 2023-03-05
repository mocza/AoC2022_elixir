defmodule RopeBridgeTest do
  use ExUnit.Case
  @moves_input [{"R", 4}, {"U", 4}, {"L", 3}, {"D", 1}, {"R", 4}, {"D", 1}, {"L", 5}, {"R", 2}]

  test "move right" do
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "R", 0) == [{{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "R", 1) == [{{1, 2}, {1, 1}}, {{1, 1}, {1, 1}}]
    assert RopeBridge.move([{{1, 1}, {1, 1}}], "R", 2) == [{{1, 3}, {1, 2}}, {{1, 2}, {1, 1}}, {{1, 1}, {1, 1}}]
  end

  test "move left" do
    assert RopeBridge.move([{{1, 2}, {1, 2}}], "L", 1) == [{{1, 1}, {1, 2}}, {{1, 2}, {1, 2}}]
    assert RopeBridge.move([{{1, 3}, {1, 3}}], "L", 2) == [{{1, 1}, {1, 2}}, {{1, 2}, {1, 3}}, {{1, 3}, {1, 3}}]
  end
end
