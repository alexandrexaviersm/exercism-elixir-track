defmodule DNA do
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000

  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T

  def encode(dna), do: do_encode(dna, <<>>)

  defp do_encode([], acc), do: acc

  defp do_encode([h | t], acc) do
    do_encode(t, <<acc::bitstring, encode_nucleotide(h)::size(4)>>)
  end

  def decode(list), do: do_decode(list, [])

  defp do_decode(<<>>, acc), do: reverse(acc)

  defp do_decode(<<a::4, rest::bitstring>>, acc) do
    do_decode(rest, [decode_nucleotide(a) | acc])
  end

  defp reverse(list), do: do_reverse(list, [])
  defp do_reverse([], acc), do: acc

  defp do_reverse([h | t], acc) do
    do_reverse(t, [h | acc])
  end
end
