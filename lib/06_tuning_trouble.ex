defmodule TuningTrouble do
  @marker %{packet: %{marker_length: 4}, message: %{marker_length: 14}}

  def marker do @marker end

  def read(file) do
    File.read!(file)
  end

  def marker_pos(string, marker_type) do
    ret = marker(String.to_charlist(string), [], @marker[marker_type][:marker_length])
    case ret do
      nil -> nil
      {remaining_signals, _marker} -> String.length(string) - length(remaining_signals)
    end
  end

  def marker(signals, acc, marker_length) do
    case {signals, acc} do
      {[], []} -> nil
      {[], marker} when length(marker) < marker_length -> nil
      {[signal_head | signal_tail], marker} ->
        # IO.inspect binding()
        if signal_in_marker?(marker, signal_head) do
          marker(signal_tail, marker_slice(marker, signal_head) ++ [signal_head], marker_length)
        else
          if last_missing_in_marker?(marker, marker_length) do {signal_tail, marker ++ [signal_head]}
          else marker(signal_tail, marker ++ [signal_head], marker_length)
          end
        end
    end
  end

  defp last_missing_in_marker?(marker, marker_length) do
    length(marker) == marker_length - 1
  end

  defp signal_in_marker?(marker, signal) do
    index = Enum.find_index(marker, &(&1 == signal))
    if index == nil do false
    else true
    end
  end

  defp marker_slice(marker, signal) do
    signal_pos_in_marker = Enum.find_index(marker, &(&1 == signal))
    Enum.slice(marker, signal_pos_in_marker+1..-1)
  end


end
