defmodule ExOptimizer.Optimizers.PngQuant do
  @moduledoc """
  [PngQuant2](https://pngquant.org/) is a lossy PNG compressor.

  We set no extra options, their defaults are used
  """

  alias ExOptimizer.{Image, Optimizer}

  @behaviour Optimizer
  @mime "image/png"
  @options ["--force"]
  @binary_name "pngquant"

  @impl Optimizer
  def can_handle(%Image{mime: mime}), do: mime == @mime

  @impl Optimizer
  def binary_name, do: @binary_name

  @impl Optimizer
  def extra_args(%Image{path: path}), do: ["--output=#{path}"]

  @impl Optimizer
  def options, do: @options
end
