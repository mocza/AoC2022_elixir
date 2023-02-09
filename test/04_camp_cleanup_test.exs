defmodule CampCleanupTest do
  use ExUnit.Case
  doctest(CampCleanup)

  test "fully overlapping" do
    assert CampCleanup.fully_overlap?(["1-10", "8-11"]) == false
    assert CampCleanup.fully_overlap?(["1-10", "2-5"]) == true
    assert CampCleanup.fully_overlap?(["1-10", "10-10"]) == true
  end


end
