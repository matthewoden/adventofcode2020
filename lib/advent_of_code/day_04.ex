defmodule AdventOfCode.Day04 do
  @optional_fields [:country_id]
  @required_fields [
    :birth_year,
    :issue_year,
    :expiration_year,
    :height,
    :eye_color,
    :hair_color,
    :passport_id,
    :passport_id
  ]
  def set_key(state, "byr:" <> rest), do: Map.put(state, :birth_year, rest)
  def set_key(state, "iyr:" <> rest), do: Map.put(state, :issue_year, rest)
  def set_key(state, "eyr:" <> rest), do: Map.put(state, :expiration_year, rest)
  def set_key(state, "hgt:" <> rest), do: Map.put(state, :height, rest)
  def set_key(state, "ecl:" <> rest), do: Map.put(state, :eye_color, rest)
  def set_key(state, "hcl:" <> rest), do: Map.put(state, :hair_color, rest)
  def set_key(state, "pid:" <> rest), do: Map.put(state, :passport_id, rest)
  def set_key(state, "cid:" <> rest), do: Map.put(state, :country_id, rest)

  def with_required_fields(state, fields),
    do: Enum.all?(fields, fn field -> Map.has_key?(state, field) end)

  def parse() do
    File.read!("./static/day4.txt")
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn passport -> String.split(passport, ["\n", " "], trim: true) end)
    |> Enum.map(fn passport ->
      Enum.reduce(passport, %{}, fn keyval, state -> set_key(state, keyval) end)
    end)
  end

  def part1(_args) do
    parse()
    |> Enum.filter(fn passport -> with_required_fields(passport, @required_fields) end)
    |> Enum.count()
  end

  def part2(_args) do
  end
end
