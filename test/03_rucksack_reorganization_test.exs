defmodule RucksackReorganizationTest do
  use ExUnit.Case
  doctest(RucksackReorganization)

  test "separate one rucksack into two compartments" do
    assert RucksackReorganization.compartments("") == {}
    assert RucksackReorganization.compartments("aA") == {"a", "A"}
    assert RucksackReorganization.compartments("vJrwpWtwJgWrhcsFMMfFFhFp") == {"vJrwpWtwJgWr", "hcsFMMfFFhFp"}
  end

  test "iterate over rucksacks and seperate each one into two compartments" do
    assert RucksackReorganization.compartments([], []) == []
    assert RucksackReorganization.compartments(["vJrwpWtwJgWrhcsFMMfFFhFp"], []) == [{"vJrwpWtwJgWr", "hcsFMMfFFhFp"}]
    assert RucksackReorganization.compartments([
      "vJrwpWtwJgWrhcsFMMfFFhFp",
      "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
      "PmmdzqPrVvPwwTWBwg",
      "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
      "ttgJtRGJQctTZtZT",
      "CrZsJsPPZsGzwwsLwLmpwMDw"], []) == [
      {"vJrwpWtwJgWr", "hcsFMMfFFhFp"},
      {"jqHRNqRjqzjGDLGL", "rsFMfFZSrLrFZsSL"},
      {"PmmdzqPrV", "vPwwTWBwg"},
      {"wMqvLMZHhHMvwLH", "jbvcjnnSBnvTQFn"},
      {"ttgJtRGJ", "QctTZtZT"},
      {"CrZsJsPPZsGz", "wwsLwLmpwMDw"}]
  end

  test "find items that both compartment contains" do
    assert RucksackReorganization.common_items({}) == []
    assert RucksackReorganization.common_items({"vJrwpWtwJgWr", "hcsFMMfFFhFp"}) == ["p"]
    assert RucksackReorganization.common_items({"vJrwpWtwJgWr", "hcsFMWfFFhFp"}) == ["p", "W"]
  end

  test "iterate over rucksack compartements and find common items" do
    assert RucksackReorganization.common_items([{"vJrwpWtwJgWr", "hcsFMMfFFhFp"}], []) == [["p"]]
    assert RucksackReorganization.common_items([
      {"vJrwpWtwJgWr", "hcsFMMfFFhFp"},
      {"jqHRNqRjqzjGDLGL", "rsFMfFZSrLrFZsSL"},
      {"PmmdzqPrV", "vPwwTWBwg"},
      {"wMqvLMZHhHMvwLH", "jbvcjnnSBnvTQFn"},
      {"ttgJtRGJ", "QctTZtZT"},
      {"CrZsJsPPZsGz", "wwsLwLmpwMDw"}], []) == [["p"], ["L"], ["P"], ["v"], ["t"], ["s"]]
  end

  test "prio" do
    assert RucksackReorganization.priority([["p"], ["L"], ["P"], ["v"], ["t"], ["s"]], []) == [16, 38, 42, 22, 20, 19]
  end

  test "lookup item priorities" do
    assert RucksackReorganization.priorities([[]], []) == [[]]
    assert RucksackReorganization.priorities([["a"]], []) == [[1]]
    assert RucksackReorganization.priorities([["a", "b"]], []) == [[1, 2]]
    assert RucksackReorganization.priorities([["a"], ["b"]], []) == [[1], [2]]
    assert RucksackReorganization.priorities([["p"], ["L"], ["P"], ["v"], ["t"], ["s"]], []) == [[16], [38], [42], [22], [20], [19]]
    assert RucksackReorganization.priorities([["p", "k"], ["L", "a"], ["P", "e", "g"], ["v"], [], ["s"]], []) == [[16, 11], [38,1], [42, 5, 7], [22], [], [19]]
  end

end
