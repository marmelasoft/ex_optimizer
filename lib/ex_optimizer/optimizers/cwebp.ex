defmodule ExOptimizer.Optimizers.Cwebp do
  @moduledoc """
  WEBPs will be optimized by [Cwebp](https://developers.google.com/speed/webp/docs/cwebp).

  These options will be used:
    * `-m 6` for the slowest compression method in order to get the best compression.
    * `-pass 10` for maximizing the amount of analysis pass.
    * `-mt` multithreading for some speed improvements.
    * `-q 90` Quality factor that brings the least noticeable changes.

  (Settings are original taken from [here](https://medium.com/@vinhlh/how-i-apply-webp-for-optimizing-images-9b11068db349))

  > Note: Due to an issue with the `cwebp` binary, options have to be set one by one, for instance the default ones are: `["-m", "6", "-pass", "10", "-mt", "-q", "80"]`
  """

  alias ExOptimizer.{Image, Optimizer}

  @behaviour Optimizer
  @mime "image/webp"
  @options ["-m", "6", "-pass", "10", "-mt", "-q", "80"]
  @binary_name "cwebp"

  @impl Optimizer
  def can_handle(%Image{mime: mime}), do: mime == @mime

  @impl Optimizer
  def binary_name, do: @binary_name

  @impl Optimizer
  def extra_args(%Image{path: path} = _image), do: ["-o", "#{path}"]

  @impl Optimizer
  def options, do: @options
end
