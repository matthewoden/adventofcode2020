defmodule AdventOfCode.Utils do
  def read(file, delimiter \\ "\n") do
    File.read!("./static/#{file}.txt") |> String.trim() |> String.split(delimiter, trim: true)
  end
end
