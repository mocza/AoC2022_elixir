defmodule TuningTrouble do
  def read(file) do
    File.read!(file)
  end

  def marker_pos(string) do
    ret = marker(String.to_charlist(string), [])
    case ret do
      nil -> nil
      {remaining_signals, _marker} -> String.length(string) - length(remaining_signals)
    end
  end

  def marker(signals, acc) do
    case {signals, acc} do
      {[], []} -> nil
      {[], marker} when length(marker) < 4 -> nil
      {[signal_head | signal_tail], marker} ->
        # IO.inspect binding()
        signal_pos_in_marker = Enum.find_index(marker, &(&1 == signal_head))
        marker_len = length(marker)
        if signal_pos_in_marker == nil do
          if marker_len == 3 do {signal_tail, marker ++ [signal_head]}
          else marker(signal_tail, marker ++ [signal_head])
          end
        else marker(signal_tail, Enum.slice(marker, signal_pos_in_marker+1..-1) ++ [signal_head])
        end
    end
  end


end
