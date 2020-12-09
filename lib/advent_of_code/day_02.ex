defmodule AdventOfCode.Day02 do
  def format() do
    File.read!("./static/day2.txt")
    |> String.split("\n", trim: true)
  end

  def valid_password_frequency(policy) do
    [min, max, character, password] = String.split(policy, [" ", ":", "-"], trim: true)

    count =
      String.graphemes(password)
      |> Enum.frequencies()
      |> Map.get(character)

    count >= String.to_integer(min) and count <= String.to_integer(max)
  end

  def part1(_args) do
    format()
    |> Enum.filter(fn line -> valid_password_frequency(line) end)
    |> Enum.count()
  end

  def valid_password_position(line) do
    [pos_a, pos_b, character, password] = String.split(line, [" ", ":", "-"], trim: true)
    pos_a = String.to_integer(pos_a) - 1
    pos_b = String.to_integer(pos_b) - 1
    positons = [String.at(password, pos_a), String.at(password, pos_b)]

    Enum.filter(positons, fn x -> x == character end) |> length() == 1
  end

  def part2(_) do
    format()
    |> Enum.filter(fn line -> valid_password_position(line) end)
    |> Enum.count()
  end
end
