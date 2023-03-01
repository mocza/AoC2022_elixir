defmodule NoSpaceLeftTest do
  use ExUnit.Case

  test "smallest dir to delete" do
    assert NoSpaceLeft.smallest_dir_to_delete(%{
      0 => %{dir: true, name: "/", parent: nil, size: 48381165},
      1 => %{dir: true, name: "a", parent: 0, size: 94853},
      4 => %{dir: true, name: "d", parent: 0, size: 24933642},
      5 => %{dir: true, name: "e", parent: 1, size: 584}}, 30000000, 70000000) == 24933642
  end

  test "calc dir size" do
    assert NoSpaceLeft.size(%{
      0 => %{dir: true, name: "/", parent: nil, size: 0},
      1 => %{dir: true, name: "a", parent: 0, size: 0},
      2 => %{dir: false, name: "b.txt", parent: 0, size: 14848514},
      3 => %{dir: false, name: "c.dat", parent: 0, size: 8504156},
      4 => %{dir: true, name: "d", parent: 0, size: 0},
      5 => %{dir: true, name: "e", parent: 1, size: 0},
      6 => %{dir: false, name: "f", parent: 1, size: 29116},
      7 => %{dir: false, name: "g", parent: 1, size: 2557},
      8 => %{dir: false, name: "h.lst", parent: 1, size: 62596},
      9 => %{dir: false, name: "i", parent: 5, size: 584},
      10 => %{dir: false, name: "j", parent: 4, size: 4060174},
      11 => %{dir: false, name: "d.log", parent: 4, size: 8033020},
      12 => %{dir: false, name: "d.ext", parent: 4, size: 5626152},
      13 => %{dir: false, name: "k", parent: 4, size: 7214296}
    }) == %{
      0 => %{dir: true, name: "/", parent: nil, size: 48381165},
      1 => %{dir: true, name: "a", parent: 0, size: 94853},
      4 => %{dir: true, name: "d", parent: 0, size: 24933642},
      5 => %{dir: true, name: "e", parent: 1, size: 584}
    }
  end

  test "parse commands as filesystem entries in map" do
    assert NoSpaceLeft.parse(["$ cd /"]) == %{0 => %{name: "/", parent: nil, dir: true, size: 0}}
    assert NoSpaceLeft.parse(["$ cd /", "$ ls", "53302 chvtw.czb"]) ==
      %{0 => %{name: "/", parent: nil, dir: true, size: 0}, 1 => %{name: "chvtw.czb", parent: 0, size: 53302, dir: false}}
    assert NoSpaceLeft.parse(["$ cd /", "$ ls", "53302 chvtw.czb", "240038 dwhl.nrn"]) ==
      %{0 => %{name: "/", parent: nil, dir: true, size: 0},
      1 => %{name: "chvtw.czb", parent: 0, size: 53302, dir: false},
      2 => %{name: "dwhl.nrn", parent: 0, size: 240038, dir: false}}
    assert NoSpaceLeft.parse(["$ cd /", "$ ls", "53302 chvtw.czb", "240038 dwhl.nrn", "dir fml"]) ==
      %{0 => %{name: "/", parent: nil, dir: true, size: 0},
      1 => %{name: "chvtw.czb", parent: 0, size: 53302, dir: false},
      2 => %{name: "dwhl.nrn", parent: 0, size: 240038, dir: false},
      3 => %{name: "fml", parent: 0, dir: true, size: 0}}
    assert NoSpaceLeft.parse(["$ cd /", "$ ls", "53302 chvtw.czb", "240038 dwhl.nrn", "dir fml", "dir nhs",
    "$ cd fml", "$ ls", "4123412 file1", "2 myfile.net", "$ cd ..", "$ cd nhs", "$ ls", "24123 file2.next", "1 file3.txt"]) == %{
        0 => %{dir: true, name: "/", parent: nil, size: 0},
        1 => %{name: "chvtw.czb", parent: 0, size: 53302, dir: false},
        2 => %{name: "dwhl.nrn", parent: 0, size: 240038, dir: false},
        3 => %{dir: true, name: "fml", parent: 0, size: 0},
        4 => %{dir: true, name: "nhs", parent: 0, size: 0},
        5 => %{name: "file1", parent: 3, size: 4123412, dir: false},
        6 => %{name: "myfile.net", parent: 3, size: 2, dir: false},
        7 => %{name: "file2.next", parent: 4, size: 24123, dir: false},
        8 => %{name: "file3.txt", parent: 4, size: 1, dir: false}
      }
    assert NoSpaceLeft.parse(["$ cd /", "$ ls", "dir a", "14848514 b.txt", "8504156 c.dat", "dir d", "$ cd a", "$ ls", "dir e", "29116 f", "2557 g", "62596 h.lst", "$ cd e", "$ ls", "584 i", "$ cd ..", "$ cd ..", "$ cd d", "$ ls", "4060174 j", "8033020 d.log", "5626152 d.ext", "7214296 k"])
    == %{0 => %{dir: true, name: "/", parent: nil, size: 0},
    1 => %{dir: true, name: "a", parent: 0, size: 0},
    2 => %{dir: false, name: "b.txt", parent: 0, size: 14848514},
    3 => %{dir: false, name: "c.dat", parent: 0, size: 8504156},
    4 => %{dir: true, name: "d", parent: 0, size: 0},
    5 => %{dir: true, name: "e", parent: 1, size: 0},
    6 => %{dir: false, name: "f", parent: 1, size: 29116},
    7 => %{dir: false, name: "g", parent: 1, size: 2557},
    8 => %{dir: false, name: "h.lst", parent: 1, size: 62596},
    9 => %{dir: false, name: "i", parent: 5, size: 584},
    10 => %{dir: false, name: "j", parent: 4, size: 4060174},
    11 => %{dir: false, name: "d.log", parent: 4, size: 8033020},
    12 => %{dir: false, name: "d.ext", parent: 4, size: 5626152},
    13 => %{dir: false, name: "k", parent: 4, size: 7214296}}
  end

end
