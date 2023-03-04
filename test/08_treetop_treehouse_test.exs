defmodule TreetopTreehouseTest do
  use ExUnit.Case
  @grid %{
    1 => %{1 => 3, 2 => 0, 3 => 3, 4 => 7, 5 => 3},
    2 => %{1 => 2, 2 => 5, 3 => 5, 4 => 1, 5 => 2},
    3 => %{1 => 6, 2 => 5, 3 => 3, 4 => 3, 5 => 2},
    4 => %{1 => 3, 2 => 3, 3 => 5, 4 => 4, 5 => 9},
    5 => %{1 => 3, 2 => 5, 3 => 3, 4 => 9, 5 => 0}
  }

  test "scenic score on the right" do
    assert TreetopTreehouse.scenic_score_right(@grid, 2, 2) == 1
    assert TreetopTreehouse.scenic_score_right(@grid, 2, 3) == 2
    assert TreetopTreehouse.scenic_score_right(@grid, 1, 1) == 2
    assert TreetopTreehouse.scenic_score_right(@grid, 3, 5) == 0
  end

  test "scenic score on the left" do
    assert TreetopTreehouse.scenic_score_left(@grid, 2, 2) == 1
    assert TreetopTreehouse.scenic_score_left(@grid, 2, 5) == 2
    assert TreetopTreehouse.scenic_score_left(@grid, 5, 1) == 0
  end

  test "scenic score down" do
    assert TreetopTreehouse.scenic_score_down(@grid, 3, 1) == 2
    assert TreetopTreehouse.scenic_score_down(@grid, 1, 1) == 2
    assert TreetopTreehouse.scenic_score_down(@grid, 1, 4) == 4
  end

  test "scenic score up" do
    assert TreetopTreehouse.scenic_score_up(@grid, 2, 1) == 1
    assert TreetopTreehouse.scenic_score_up(@grid, 2, 2) == 1
    assert TreetopTreehouse.scenic_score_up(@grid, 5, 4) == 4
  end

  test "scenic score for 4 directions" do
    assert TreetopTreehouse.scenic_score(@grid, 2, 3) == 4
    assert TreetopTreehouse.scenic_score(@grid, 4, 3) == 8
  end

  test "scenic score for all trees" do
    assert TreetopTreehouse.scenic_score(@grid) ==  %{
      1 => %{1 => %{height: 3, score: 0}, 2 => %{height: 0, score: 0}, 3 => %{height: 3, score: 0}, 4 => %{height: 7, score: 0}, 5 => %{height: 3, score: 0}},
      2 => %{1 => %{height: 2, score: 0}, 2 => %{height: 5, score: 1}, 3 => %{height: 5, score: 4}, 4 => %{height: 1, score: 1}, 5 => %{height: 2, score: 0}},
      3 => %{1 => %{height: 6, score: 0}, 2 => %{height: 5, score: 6}, 3 => %{height: 3, score: 1}, 4 => %{height: 3, score: 2}, 5 => %{height: 2, score: 0}},
      4 => %{1 => %{height: 3, score: 0}, 2 => %{height: 3, score: 1}, 3 => %{height: 5, score: 8}, 4 => %{height: 4, score: 3}, 5 => %{height: 9, score: 0}},
      5 => %{1 => %{height: 3, score: 0}, 2 => %{height: 5, score: 0}, 3 => %{height: 3, score: 0}, 4 => %{height: 9, score: 0}, 5 => %{height: 0, score: 0}}
    }
  end

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
    assert TreetopTreehouse.parse(["30373"]) == %{1 => %{1 => 3, 2 => 0, 3 => 3, 4 => 7, 5 => 3}}
    assert TreetopTreehouse.parse(["30373", "25512"]) == %{1 => %{1 => 3, 2 => 0, 3 => 3, 4 => 7, 5 => 3}, 2 => %{1 => 2, 2 => 5, 3 => 5, 4 => 1, 5 => 2}}
    assert TreetopTreehouse.parse(["30373", "25512", "65332", "33549", "35390"]) == %{
      1 => %{1 => 3, 2 => 0, 3 => 3, 4 => 7, 5 => 3},
      2 => %{1 => 2, 2 => 5, 3 => 5, 4 => 1, 5 => 2},
      3 => %{1 => 6, 2 => 5, 3 => 3, 4 => 3, 5 => 2},
      4 => %{1 => 3, 2 => 3, 3 => 5, 4 => 4, 5 => 9},
      5 => %{1 => 3, 2 => 5, 3 => 3, 4 => 9, 5 => 0}
    }
  end


end
