defmodule TreetopTreehouseTest do
  use ExUnit.Case

  test "visible on edge" do
    assert TreetopTreehouse.visible_on_edge(%{1 => %{1 => 3, 2 => 0, 3 => 3}, 2 => %{1 => 2, 2 => 5, 3 => 5}, 3 => %{1 => 6, 2 => 5, 3 => 3}}) == 8
  end

  test "visible trees" do
    assert TreetopTreehouse.visible(%{1 => %{1 => 3, 2 => 0, 3 => 3}, 2 => %{1 => 2, 2 => 5, 3 => 5}, 3 => %{1 => 6, 2 => 5, 3 => 3}}) == [{2, 2}]
    assert TreetopTreehouse.parse(["30373", "25512", "65332", "33549", "35390"]) |> TreetopTreehouse.visible() == [{2, 2}, {2, 3}, {3, 2}, {3, 4}, {4, 3}]
  end

  test "visible horizontally" do
    assert TreetopTreehouse.visible_horizontally(%{1 => %{1 => 3, 2 => 0, 3 => 3}, 2 => %{1 => 2, 2 => 5, 3 => 5}, 3 => %{1 => 6, 2 => 5, 3 => 3}}, 2, 2) == true
  end

  test "visible vertically" do
    assert TreetopTreehouse.visible_vertically(%{1 => %{1 => 3, 2 => 0, 3 => 3}, 2 => %{1 => 2, 2 => 5, 3 => 5}, 3 => %{1 => 6, 2 => 5, 3 => 3}}, 2, 2) == true
  end

  test "parse" do
    assert TreetopTreehouse.parse(["30373"]) == %{1 => %{1 => "3", 2 => "0", 3 => "3", 4 => "7", 5 => "3"}}
    assert TreetopTreehouse.parse(["30373", "25512"]) == %{
      1 => %{1 => "3", 2 => "0", 3 => "3", 4 => "7", 5 => "3"},
      2 => %{1 => "2", 2 => "5", 3 => "5", 4 => "1", 5 => "2"}}
    assert TreetopTreehouse.parse(["30373", "25512", "65332", "33549", "35390"]) == %{
      1 => %{1 => "3", 2 => "0", 3 => "3", 4 => "7", 5 => "3"},
      2 => %{1 => "2", 2 => "5", 3 => "5", 4 => "1", 5 => "2"},
      3 => %{1 => "6", 2 => "5", 3 => "3", 4 => "3", 5 => "2"},
      4 => %{1 => "3", 2 => "3", 3 => "5", 4 => "4", 5 => "9"},
      5 => %{1 => "3", 2 => "5", 3 => "3", 4 => "9", 5 => "0"}
    }
  end


end
