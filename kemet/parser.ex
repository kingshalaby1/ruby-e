defmodule Parser do
  @moduledoc false
def run() do
  input = """
select
      col1 from (
  select col2, col3 from (
    select col4, col5, col6 from some_table))
"""
#  input = "2select foo from bar"
  IO.puts("input: #{inspect(input)}")
  parse(input)
end

  @spec parse(String.t) :: {:ok, number(), String.t} | {:error, String.t}
  def parse(input) do
    parser = many(token(identifier()))
#    parser = sequence([])
    parser.(input)
  end

  defp token(parser) do
    sequence([
      many(choice([char(?\s), char(?\n)])),
      parser,
      many(choice([char(?\s), char(?\n)]))
    ])
    |> map(fn [_leading_spaces, term, _trailing_spaces] -> term end)
  end

  defp sequence(parsers) do
    fn input ->
      case parsers do
        [] -> {:ok, [], input}
        [first_parser | other_parsers] ->
          with {:ok, term, rest} <- first_parser.(input),
               {:ok, other_terms, rest} <- sequence(other_parsers).(rest) do

                  {:ok, [term | other_terms], rest}
               end
      end
    end
  end

  defp identifier() do
    many(identifier_char())
    |> satisfy(fn chars -> chars != [] end)
    |> map(&to_string/1)
  end

  def map(parser, mapper) do
    fn input ->
      with {:ok, term, rest} <- parser.(input) do
        {:ok, mapper.(term), rest}
      end
    end
  end

  defp many(parser) do
    fn input ->
      case parser.(input) do
        {:error, _reason} -> {:ok, [], input}
        {:ok, first, rest} ->
          {:ok, other, rest} = many(parser).(rest)
          {:ok, [first | other], rest}

      end
    end
  end

  defp identifier_char(), do: choice([digit(), ascii_letter(), char(?_)])

  defp choice(parsers) do
    fn input ->
      case parsers do
        [] -> {:error, "no parser succeeded"}
        [first | rest] ->
          with {:error, _reason} <- first.(input),
            do: choice(rest).(input)
      end
    end
  end

  defp digit(), do: satisfy(char(), fn char -> char in ?0..?9 end)
  defp ascii_letter(), do: satisfy(char(), fn char -> char in ?A..?Z or char in ?a..?z end)
  defp char(expected), do: satisfy(char(), fn char -> char == expected end)

  defp satisfy(parser, acceptor) do
    fn input ->
      with {:ok, term, rest} <- parser.(input) do
        if acceptor.(term),
          do: {:ok, term, rest},
          else: {:error, "term rejected"}
      end
    end
  end

  defp char() do
    fn input ->
      case input do
        "" -> {:error, "unexpected end of input"}
        <<char::utf8, rest::binary>> -> {:ok, char, rest}
      end
    end
  end
  
end

Parser.run()
