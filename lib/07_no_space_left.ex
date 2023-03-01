defmodule NoSpaceLeft do
  @cmd_input %{
           root: %{name: "change to root dir", pattern: ~r"\$ cd /" },
           down: %{name: "change current directory to child", pattern: ~r"\$ cd (?<dirname>\w+)" },
           ls: %{name: "list current directory", pattern: ~r"^\$ ls"},
           dir: %{name: "directory entry", pattern: ~r"^dir (?<dirname>\w+)"},
           file: %{name: "file entry", pattern: ~r"^(?<size>\d+) (?<filename>\w+.*\w*)"},
           up: %{name: "change current directory to parent", pattern: ~r"^\$ cd .."},
  }
  # @root %FileSystem{0 => %DirNode{name: "/", parent: nil, children: []}}

  defmodule FileSystemMap do
    defmodule Dir do
      defstruct [:name, :parent, :subdirs, :files]
    end

    defmodule File do
      defstruct [:name, :parent, :size]
    end

    def next_id(filesystem) do
      elem(Enum.max_by(filesystem, fn {k, _v} -> k end), 0) + 1
    end

    def current_dir(filesystem) do
      filesystem
      |> Enum.filter(fn {_k, v} -> v. == NoSpaceLeft.FilesystemMap.Dir end)
      # |> Enum.filter(fn {_k, v} -> v.__struct__ == NoSpaceLeft.FilesystemMap.Dir end)
      # elem(Enum.max_by(filesystem, fn {k, v} -> k and v.__struct__ == 'FilesystemMap.Dir' end), 0) + 1
    end

    def init() do
      # %FileSystemMap{next_id: 0, node: %DirNode{name: "/"}}
      %{0 => %Dir{name: "/"}}
    end

    def add_dir(filesystem, dirname, cwd_id) do
      Map.put(filesystem, next_id(filesystem), %Dir{name: dirname, parent: cwd_id})
    end

  end



  # %{1 => %{node: :dir, name: "/", childred: [2], parent: nil}}
  # %{2 => %{node: :dir, name: "a", childred: [], parent: 1}}
  # %{3 => %{node: :file, name: "file1.txt", size: 10000, parent: 2}}


  # def parse_command(cmd, filesystem, current_dir) do
  #   cond do
  #     dirname = Regex.named_captures(@cmd_input[:down][:pattern], cmd)["dirname"] ->
  #       add_dir(filesystem, dirname)
  #       parse_command(cmd)
  #       current_dir = dirname
  #     Regex.match(@cmd_input[:up][:pattern], cmd) -> Map.get(filesystem, current_dir = for {, %{}}

  #     Map.put(filesystem, FileSystem.next_id(filesystem), %DirNode{name: dirname, parent: current_dir})
  #   end
  # end

  def parse(commands) do
    case commands do
      [] -> "Commands list must not be empty"
      [cmd | tail] ->
        cond do
          Regex.match?(@cmd_input[:root][:pattern], cmd) ->
            filesystem = parse(tail, 1, 0, %{0 => %{name: "/", parent: nil, dir: true}}, 0)
            calc_root_size(filesystem)
          true -> ~s(The very first command must be "cd /" but was #{cmd})
        end
    end
  end

  defp calc_root_size(filesystem) do
    calc_root_size = for {_id, %{parent: parent, size: size}} <- filesystem, parent == 0, reduce: 0 do
      acc -> size + acc
    end
    root = Map.get(filesystem, 0)
    root_with_size = Map.put(root, :size, calc_root_size)
    Map.put(filesystem, 0, root_with_size)
  end

  # def size(filesystem, id) do
  #   # children = Enum.filter(filesystem, fn {child_id, %{parent: parent}}, parent == id -> child_id end)
  #   for {child_id, %{parent: parent, size: size, dir: dir}} <- filesystem, parent == id do: {id, size(filesystem, child_id)}
  #     cond dir do
  #       false -> size
  #       true: size(child_id, filesystem)
  #     end
  #   end
  # end

  def size(filesystem) do
    for {id, entry} <- filesystem, entry.dir, into: %{}, do: {id, %{entry | :size => size(filesystem, id, 0)}}
  end

  def size(filesystem, dir_id, dir_size_acc) do
    # for {child_id, %{parent: parent, size: size, dir: dir}} <- filesystem, parent == id, into: 0 do
    #   case dir do
    #     true -> acc + size(filesystem, child_id, 0)
    #     false -> acc + size
    #   end
    # end
    filesystem
    |> Enum.filter(fn {_, %{parent: parent}} -> parent == dir_id end)
    |> Enum.reduce(dir_size_acc, fn {child_id, entry}, acc -> if entry.dir do acc + size(filesystem, child_id, 0) else acc + entry.size end end)
  end



  defp parse(commands, next_id, cwd_id, filesystem, size_acc) do
    # IO.inspect binding()
    case commands do
      [] ->
        last_dir = Map.get(filesystem, cwd_id)
        last_dir_with_size = Map.put(last_dir, :size, size_acc)
        Map.put(filesystem, cwd_id, last_dir_with_size)
      [cmd | tail] ->
        cond do
          dirname = Regex.named_captures(@cmd_input[:down][:pattern], cmd)["dirname"] ->
            [new_cwd_id | _] = for {id, %{name: name, parent: parent}} <- filesystem, parent == cwd_id, name == dirname, do: id
            parse(tail, next_id, new_cwd_id, filesystem, 0)
          Regex.match?(@cmd_input[:up][:pattern], cmd) ->
            current_dir = Map.get(filesystem, cwd_id)
            current_dir_with_size = Map.put(current_dir, :size, size_acc)
            filesystem = Map.put(filesystem, cwd_id, current_dir_with_size)
            parse(tail, next_id, current_dir_with_size.parent, filesystem, size_acc)
          Regex.match?(@cmd_input[:ls][:pattern], cmd) ->
            parse(tail, next_id, cwd_id, filesystem, size_acc)
          dirname = Regex.named_captures(@cmd_input[:dir][:pattern], cmd)["dirname"] ->
            filesystem = Map.put(filesystem, next_id, %{name: dirname, parent: cwd_id, dir: true, size: 0})
            parse(tail, next_id + 1, cwd_id, filesystem, size_acc)
          %{"filename" => filename, "size" => size} = Regex.named_captures(@cmd_input[:file][:pattern], cmd) ->
            filesize = String.to_integer(size)
            filesystem = Map.put(filesystem, next_id, %{name: filename, parent: cwd_id, size: filesize, dir: false})
            parse(tail, next_id + 1, cwd_id, filesystem, size_acc + filesize)
        end
    end
  end

  def read(file) do
    String.split(File.read!(file), "\n")
  end

  def smallest_dir_to_delete(filesystem, free_space_required, total_disk_space_available) do
    current_free_space = total_disk_space_available - filesystem[0].size
    need_to_free_up = free_space_required - current_free_space
    IO.inspect binding()
    if need_to_free_up <= 0 do
      nil
    else
        filesystem
        |> Enum.filter(fn {_, %{size: size}} -> size >= need_to_free_up end)
        |> Enum.min_by(fn {_, %{size: size}} -> size end)
    end
  end

end
