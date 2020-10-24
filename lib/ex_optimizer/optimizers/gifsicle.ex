defmodule ExOptimizer.Optimizers.Gifsicle do
  @moduledoc """
  GIFs will be optimized by [Gifsicle](http://www.lcdf.org/gifsicle).

  These options will be used:

    * `-O3`: this sets the optimization level to Gifsicle's maximum, which produces the slowest but best results
  """

  alias ExOptimizer.{Image, Optimizer}

  @behaviour Optimizer
  @mime "image/gif"
  @options ["-b", "-O3"]
  @binary_name "gifsicle"

  @impl Optimizer
  def can_handle(%Image{mime: mime}), do: mime == @mime

  @impl Optimizer
  def binary_name, do: @binary_name

  @impl Optimizer
  def extra_args(%Image{path: path} = _image), do: ["--output=#{path}"]

  @impl Optimizer
  def options, do: @options
end
