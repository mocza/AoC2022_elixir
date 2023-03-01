defmodule NoSpaceLeft do
  @cmd_input %{
           root: %{name: "change to root dir", pattern: ~r"\$ cd /" },
           down: %{name: "change current directory to child", pattern: ~r"\$ cd (?<dirname>\w+)" },
           ls: %{name: "list current directory", pattern: ~r"^\$ ls"},
           dir: %{name: "directory entry", pattern: ~r"^dir (?<dirname>\w+)"},
           file: %{name: "file entry", pattern: ~r"^(?<size>\d+) (?<filename>\w+.*\w*)"},
           up: %{name: "change current directory to parent", pattern: ~r"^\$ cd .."},
  }

  def size(filesystem) do
    for {id, entry} <- filesystem, entry.dir, into: %{}, do: {id, %{entry | :size => size(filesystem, id, 0)}}
  end

  defp size(filesystem, dir_id, dir_size) do
    filesystem
    |> Enum.filter(fn {_, %{parent: parent}} -> parent == dir_id end)
    |> Enum.reduce(dir_size, fn {child_id, entry}, acc -> if entry.dir do acc + size(filesystem, child_id, 0) else acc + entry.size end end)
    # for {child_id, %{parent: parent, dir: dir, size: size}} <- filesystem, parent == dir_id, reduce: dir_size do
    #   acc -> if dir do acc + size(filesystem, child_id, 0) else acc + size end
    # end
  end

  def parse(commands) do
    case commands do
      [] -> "Commands list must not be empty"
      [cmd | tail] ->
        cond do
          Regex.match?(@cmd_input[:root][:pattern], cmd) ->
            parse(tail, 1, 0, %{0 => %{name: "/", parent: nil, dir: true, size: 0}})
          true -> ~s(The very first command must be "cd /" but was #{cmd})
        end
    end
  end

  defp parse(commands, next_id, cwd_id, filesystem) do
    case commands do
      [] -> filesystem
      [cmd | tail] ->
        cond do
          dirname = Regex.named_captures(@cmd_input[:down][:pattern], cmd)["dirname"] ->
            [new_cwd_id | _] = for {id, %{name: name, parent: parent}} <- filesystem, parent == cwd_id, name == dirname, do: id
            parse(tail, next_id, new_cwd_id, filesystem)
          Regex.match?(@cmd_input[:up][:pattern], cmd) ->
            current_dir = Map.get(filesystem, cwd_id)
            parse(tail, next_id, current_dir.parent, filesystem)
          Regex.match?(@cmd_input[:ls][:pattern], cmd) ->
            parse(tail, next_id, cwd_id, filesystem)
          dirname = Regex.named_captures(@cmd_input[:dir][:pattern], cmd)["dirname"] ->
            filesystem = Map.put(filesystem, next_id, %{name: dirname, parent: cwd_id, dir: true, size: 0})
            parse(tail, next_id + 1, cwd_id, filesystem)
          %{"filename" => filename, "size" => size} = Regex.named_captures(@cmd_input[:file][:pattern], cmd) ->
            filesize = String.to_integer(size)
            filesystem = Map.put(filesystem, next_id, %{name: filename, parent: cwd_id, size: filesize, dir: false})
            parse(tail, next_id + 1, cwd_id, filesystem)
        end
    end
  end

  def read(file) do
    String.split(File.read!(file), "\n")
  end

  def smallest_dir_to_delete(filesystem, free_space_required, total_disk_space_available) do
    current_free_space = total_disk_space_available - filesystem[0].size
    need_to_free_up = free_space_required - current_free_space
    if need_to_free_up <= 0 do
      nil
    else
        # min_dir_size_comprehension(filesystem, need_to_free_up)
        min_dir_size_enumerate(filesystem, need_to_free_up)
    end
  end

  defp min_dir_size_enumerate(filesystem, need_to_free_up) do
      filesystem
      |> Map.values()
      |> Enum.filter(& &1.size >= need_to_free_up)
      |> Enum.min_by(& &1.size)
      |> Map.get(:size)
  end

  defp min_dir_size_comprehension(filesystem, need_to_free_up) do
    min_dir_id = for {id, dir} <- filesystem, dir.size >= need_to_free_up, reduce: 0 do
      acc -> if dir.size < filesystem[acc].size do id else acc end
    end
    filesystem[min_dir_id].size
  end

end
