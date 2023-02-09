defmodule CampCleanupTest do
  use ExUnit.Case
  doctest(CampCleanup)

  test "fully overlap" do
    assert CampCleanup.fully_overlap?(["1-10", "8-11"]) == false
    assert CampCleanup.fully_overlap?(["1-10", "2-5"]) == true
    assert CampCleanup.fully_overlap?(["1-10", "10-10"]) == true
  end

  test "overlap" do
    assert CampCleanup.overlap?(["1-10", "8-11"]) == true
    assert CampCleanup.overlap?(["1-4", "4-11"]) == true
    assert CampCleanup.overlap?(["1-10", "2-5"]) == true
    assert CampCleanup.overlap?(["1-5", "5-5"]) == true
    assert CampCleanup.overlap?(["1-5", "6-10"]) == false
  end

end
