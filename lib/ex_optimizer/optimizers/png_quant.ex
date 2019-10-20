defmodule ExOptimizer.Optimizers.PngQuant do
  @moduledoc """
  [PngQuant2](https://pngquant.org/) is a lossy PNG compressor.

  We set no extra options, their defaults are used
  """

  alias ExOptimizer.{Image, Optimizer}

  @behaviour Optimizer
  @mime "image/png"
  @options ["--force"]

  @impl Optimizer
  def can_handle(%Image{mime: mime}), do: mime == @mime

  @impl Optimizer
  def binary_name(), do: "pngquant"

  @impl Optimizer
  def extra_args(%Image{path: path}), do: ["--output=#{path}"]

  @impl Optimizer
  def options(), do: @options
end
