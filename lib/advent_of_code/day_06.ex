defmodule AdventOfCode.Day06 do
  alias AdventOfCode.Utils

  @moduledoc """
  For part 1, it's a sum of thecount of keys within a frequency map of answers.

  For part 2, it's the same, but the map is filtered down to frequencies that
  match the number of respondants
  """
  def as_frequencies(group) do
    (group <> "\n")
    |> String.graphemes()
    |> Enum.frequencies()
  end

  def part1(_args) do
    Utils.read("day6", "\n\n")
    |> Enum.map(fn group ->
      as_frequencies(group) |> Enum.count(fn {key, _} -> key != "\n" end)
    end)
    |> Enum.sum()
  end

  def part2(_args) do
    Utils.read("day6", "\n\n")
    |> Enum.map(fn group ->
      {respondants, answers} = as_frequencies(group) |> Map.pop("\n", 0)

      Enum.count(answers, fn {_key, value} -> value == respondants end)
    end)
    |> Enum.sum()
  end
end
