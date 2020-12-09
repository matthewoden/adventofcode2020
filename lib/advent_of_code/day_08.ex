defmodule AdventOfCode.Day08 do
  alias AdventOfCode.Utils

  def parse() do
    lines = Utils.read("day8") |> Enum.with_index()

    initial_state = %{
      size: length(lines),
      seen: %{},
      index: 0,
      acc: 0,
      commands: %{},
      terminated_normally: false
    }

    Enum.reduce(lines, initial_state, fn {command, index}, state ->
      [op, int] = String.split(command, " ")
      {int, _} = Integer.parse(int)
      put_in(state, [:commands, index], {op, int})
    end)
  end

  def step(%{size: size, index: size} = state), do: %{state | terminated_normally: true}

  def step(%{seen: seen, index: index} = state) when is_map_key(seen, index), do: state

  def step(%{commands: commands, index: index} = state) do
    state = %{state | index: index + 1, seen: Map.put(state.seen, index, true)}

    case Map.get(commands, index) do
      {"acc", val} -> step(%{state | acc: state.acc + val})
      {"nop", _} -> step(state)
      {"jmp", val} -> step(%{state | index: index + val})
    end
  end

  def to_combinations(state) do
    Enum.map(0..state.size, fn index ->
      %{
        state
        | commands:
            Map.update(state.commands, index, nil, fn
              {"nop", val} -> {"jmp", val}
              {"jmp", val} -> {"nop", val}
              otherwise -> otherwise
            end)
      }
    end)
  end

  def part1(_args) do
    parse() |> step() |> Map.get(:acc)
  end

  def part2(_args) do
    parse()
    |> to_combinations()
    |> Task.async_stream(&step/1)
    |> Enum.find(fn {:ok, state} -> state.terminated_normally end)
  end
end
