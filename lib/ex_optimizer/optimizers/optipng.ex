defmodule ExOptimizer.Optimizers.Optipng do
  @moduledoc """
  [Optipng](http://optipng.sourceforge.net) is another PNG compressor.

  The following options are used:

    * `-i0`: this will result in a non-interlaced, progressive scanned image
    * `-o2`: this set the optimization level to two (multiple IDAT compression trials)
  """

  alias ExOptimizer.{Image, Optimizer}

  @behaviour Optimizer
  @mime "image/png"
  @options ["-i0", "-o2", "-quiet"]

  @impl Optimizer
  def can_handle(%Image{mime: mime}), do: mime == @mime

  @impl Optimizer
  def binary_name(), do: "optipng"

  @impl Optimizer
  def extra_args(%Image{} = _image), do: []

  @impl Optimizer
  def options(), do: @options
end
