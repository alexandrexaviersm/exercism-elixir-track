defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    do_extract_from_path(data, keys(path))
  end

  defp do_extract_from_path(data, []), do: data

  defp do_extract_from_path(data, [key | rest]) do
    do_extract_from_path(data[key], rest)
  end

  def get_in_path(data, path) do
    get_in(data, keys(path))
  end

  defp keys(path) do
    String.split(path, ".", trim: true)
  end
end
