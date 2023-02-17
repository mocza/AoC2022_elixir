defmodule TuningTroubleTest do
  use ExUnit.Case

  test "find first marker position" do
    assert TuningTrouble.marker_pos("") == nil
    assert TuningTrouble.marker_pos("mjqj") == nil
    assert TuningTrouble.marker_pos("mjqp") == 4
    assert TuningTrouble.marker_pos("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
    assert TuningTrouble.marker_pos("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
    assert TuningTrouble.marker_pos("nppdvjthqldpwncqszvftbrmjlhg") == 6
    assert TuningTrouble.marker_pos("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
    assert TuningTrouble.marker_pos("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
  end

  test "find first marker" do
    assert TuningTrouble.marker(String.to_charlist(""), []) == nil
    assert TuningTrouble.marker(String.to_charlist("m"), []) == nil
    assert TuningTrouble.marker(String.to_charlist("mj"), []) == nil
    assert TuningTrouble.marker(String.to_charlist("mjq"), []) == nil
    assert TuningTrouble.marker(String.to_charlist("mjqj"), []) == nil
    assert TuningTrouble.marker(String.to_charlist("mjqx"), []) == {[], 'mjqx'}
    assert TuningTrouble.marker(String.to_charlist("mjqjpqmgbljsphdztnvjfqwrcgsmlb"), []) == {'gbljsphdztnvjfqwrcgsmlb', 'jpqm'}
    assert TuningTrouble.marker(String.to_charlist("bvwbjplbgvbhsrlpgdmjqwftvncz"), []) == {'plbgvbhsrlpgdmjqwftvncz', 'vwbj'}
    assert TuningTrouble.marker(String.to_charlist("nppdvjthqldpwncqszvftbrmjlhg"), []) == {'thqldpwncqszvftbrmjlhg', 'pdvj'}
    assert TuningTrouble.marker(String.to_charlist("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"), []) == {'jfmvfwmzdfjlvtqnbhcprsg', 'rfnt'}
    assert TuningTrouble.marker(String.to_charlist("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"), []) == {'ljwzlrfnpqdbhtmscgvjw', 'zqfr'}
  end

end
