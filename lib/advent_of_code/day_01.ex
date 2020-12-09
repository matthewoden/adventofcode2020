defmodule AdventOfCode.Day01 do
  def format() do
    File.read!("./static/day1.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part1(_args) do
    {a, b} = format() |> match_sum()
    a * b
  end

  def match_sum([val | rest]) do
    found = Enum.find(rest, nil, fn cur -> cur + val == 2020 end)
    {val, found}
  end

  def part2(_args) do
    list = format()

    Stream.map(list, fn x ->
      list
      |> Stream.filter(fn y -> x + y < 2020 end)
      |> Stream.map(fn y ->
        Enum.find_value(list, fn z ->
          if x + y + z === 2020 do
            x * y * z
          end
        end)
      end)
    end)
    |> Stream.concat()
    |> Stream.filter(fn x -> x end)
    |> Enum.take(1)
  end
end
