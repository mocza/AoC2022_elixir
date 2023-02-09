defmodule CampCleanup do
  def fully_overlap?([first_range_string, second_range_string]) do
    [range_first, range_last] = String.split(first_range_string, "-")
    range1 = Range.new(String.to_integer(range_first), String.to_integer(range_last))
    [range_first, range_last] = String.split(second_range_string, "-")
    range2 = Range.new(String.to_integer(range_first), String.to_integer(range_last))
    Enum.reduce(range1, true, fn i, acc -> Enum.member?(range2, i) and acc end)
    or
    Enum.reduce(range2, true, fn i, acc -> Enum.member?(range1, i) and acc end)
  end

  def fully_overlap?(_string) do
    false
  end

  def read(path) do
    String.split(File.read!(path), "\n")
  end

end
