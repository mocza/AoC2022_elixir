defmodule CampCleanup do
  @spec fully_overlap?(any) :: any
  def fully_overlap?([first_range_string, second_range_string]) do
    {range1, range2} = parse_range([first_range_string, second_range_string])
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

  defp parse_range([first_range_string, second_range_string]) do
    [range_first, range_last] = String.split(first_range_string, "-")
    range1 = Range.new(String.to_integer(range_first), String.to_integer(range_last))
    [range_first, range_last] = String.split(second_range_string, "-")
    range2 = Range.new(String.to_integer(range_first), String.to_integer(range_last))
    {range1, range2}
  end

  def overlap?([first_range_string, second_range_string]) do
    {range1, range2} = parse_range([first_range_string, second_range_string])
    Enum.reduce(range1, false, fn i, acc -> Enum.member?(range2, i) or acc end)
    or
    Enum.reduce(range2, false, fn i, acc -> Enum.member?(range1, i) or acc end)
  end

  def overlap?(_string) do
    false
  end

end
