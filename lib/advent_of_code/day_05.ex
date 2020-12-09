defmodule AdventOfCode.Day05 do
  def parse() do
    File.read!("./static/day5.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.replace(~r/F|L/, "0")
      |> String.replace(~r/B|R/, "1")
      |> String.to_integer(2)
    end)
  end

  def part1(_args) do
    Enum.max(parse())
  end

  def part2(_args) do
    # 53..896 - range between the max id, and min id in my parsed input
    MapSet.difference(MapSet.new(53..896), MapSet.new(parse()))
  end
end
