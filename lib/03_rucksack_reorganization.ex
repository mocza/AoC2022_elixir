defmodule RucksackReorganization do
  @item_priority Map.new(Enum.zip(?a..?z, 1..26) ++ Enum.zip(?A..?Z, 27..52))

  def compartments(rucksack) do
    itemcount = String.length(rucksack)
    cond do
      itemcount == 0 -> {}
      rem(itemcount, 2) == 0 -> String.split_at(rucksack, div(itemcount, 2))
    end
  end

  def compartments([nextrucksack | rest], compartments) do
    compartments(rest, compartments ++ [compartments(nextrucksack)])
  end

  def compartments([], compartments) do
    compartments
  end

  def common_items({}) do
    []
  end

  def common_items({compartment1, compartment2}) do
    Enum.uniq(Enum.filter(String.codepoints(compartment1), &(&1 in String.codepoints(compartment2))))
  end

  def common_items([], common_items) do
    common_items
  end

  def common_items([first | rest], common_items) do
    common_items(rest, common_items ++ [Enum.uniq(common_items(first))])
  end

  def to_codepoint(string) do
    <<codepoint::utf8>> = string
    codepoint
  end

  def priority(item) do
    @item_priority[to_codepoint(item)]
    # @item_priority[hd(to_charlist(item))]
  end

  def priority(item, priorities) do
    case item do
      [] -> priorities
      [head | tail] -> priority(tail, priority(head, priorities))
      _ -> priorities ++ [priority(item)]
    end
  end

  def priorities(nested_list, priorities) do
    case nested_list do
      [] -> priorities
      [head | []] -> [priority(head, priorities)]
      [head | tail] -> [priority(head, priorities)] ++ priorities(tail, priorities)
    end
  end

  def read(path) do
    String.split(File.read!(path), "\n")
  end

end
