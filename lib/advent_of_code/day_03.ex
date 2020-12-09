defmodule AdventOfCode.Day03 do
  def format() do
    File.read!("./static/day3.txt")
    |> String.split("\n", trim: true)
  end

  def traverse(lines, right, down) do
    width = String.length(hd(lines))

    lines
    |> Enum.drop(down)
    |> Enum.take_every(down)
    |> Enum.reduce(%{position: 0, trees: 0}, fn line, acc ->
      new_position = rem(acc.position + right, width)

      trees =
        case String.at(line, new_position) do
          "#" -> acc.trees + 1
          _ -> acc.trees
        end

      %{position: new_position, trees: trees}
    end)
  end

  def part1(_args) do
    format() |> traverse(3, 1) |> Map.get(:trees)
  end

  def part2(_args) do
    lines = format()

    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(fn {right, down} -> traverse(lines, right, down) end)
    |> Enum.reduce(1, fn x, acc -> x.trees * acc end)
  end
end
