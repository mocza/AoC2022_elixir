defmodule TuningTroubleTest do
  use ExUnit.Case
  @packet_marker_length TuningTrouble.marker[:packet][:marker_length]
  @message_marker_length TuningTrouble.marker[:message][:marker_length]

  test "find first packet marker" do
    assert TuningTrouble.marker(String.to_charlist(""), [], @packet_marker_length) == nil
    assert TuningTrouble.marker(String.to_charlist("m"), [], @packet_marker_length) == nil
    assert TuningTrouble.marker(String.to_charlist("mj"), [], @packet_marker_length) == nil
    assert TuningTrouble.marker(String.to_charlist("mjq"), [], @packet_marker_length) == nil
    assert TuningTrouble.marker(String.to_charlist("mjqj"), [], @packet_marker_length) == nil
    assert TuningTrouble.marker(String.to_charlist("mjqx"), [], @packet_marker_length) == {[], 'mjqx'}
    assert TuningTrouble.marker(String.to_charlist("mjqjpqmgbljsphdztnvjfqwrcgsmlb"), [], @packet_marker_length) == {'gbljsphdztnvjfqwrcgsmlb', 'jpqm'}
    assert TuningTrouble.marker(String.to_charlist("bvwbjplbgvbhsrlpgdmjqwftvncz"), [], @packet_marker_length) == {'plbgvbhsrlpgdmjqwftvncz', 'vwbj'}
    assert TuningTrouble.marker(String.to_charlist("nppdvjthqldpwncqszvftbrmjlhg"), [], @packet_marker_length) == {'thqldpwncqszvftbrmjlhg', 'pdvj'}
    assert TuningTrouble.marker(String.to_charlist("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"), [], @packet_marker_length) == {'jfmvfwmzdfjlvtqnbhcprsg', 'rfnt'}
    assert TuningTrouble.marker(String.to_charlist("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"), [], @packet_marker_length) == {'ljwzlrfnpqdbhtmscgvjw', 'zqfr'}
  end

  test "find position of first packet marker" do
    assert TuningTrouble.marker_pos("", :packet) == nil
    assert TuningTrouble.marker_pos("mjqj", :packet) == nil
    assert TuningTrouble.marker_pos("mjqp", :packet) == 4
    assert TuningTrouble.marker_pos("mjqjpqmgbljsphdztnvjfqwrcgsmlb", :packet) == 7
    assert TuningTrouble.marker_pos("bvwbjplbgvbhsrlpgdmjqwftvncz", :packet) == 5
    assert TuningTrouble.marker_pos("nppdvjthqldpwncqszvftbrmjlhg", :packet) == 6
    assert TuningTrouble.marker_pos("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", :packet) == 10
    assert TuningTrouble.marker_pos("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", :packet) == 11
  end

  test "find first message marker" do
    assert TuningTrouble.marker(String.to_charlist("mjqjpqmgbljsphdztnvjfqwrcgsmlb"), [], @message_marker_length) == {'jfqwrcgsmlb', 'qmgbljsphdztnv'}
  end

  test "find position of first message marker" do
    assert TuningTrouble.marker_pos("mjqjpqmgbljsphdztnvjfqwrcgsmlb", :message) == 19
    assert TuningTrouble.marker_pos("bvwbjplbgvbhsrlpgdmjqwftvncz", :message) == 23
    assert TuningTrouble.marker_pos("nppdvjthqldpwncqszvftbrmjlhg", :message) == 23
    assert TuningTrouble.marker_pos("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", :message) == 29
    assert TuningTrouble.marker_pos("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", :message) == 26
  end

end
