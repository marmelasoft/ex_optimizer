defmodule ExOptimizer.Optimizers.Svgo do
  @moduledoc """
  SVGs will be minified by [SVGO](https://github.com/svg/svgo).

  SVGO's default configuration will be used, with the omission of the cleanupIDs plugin because that one is known to cause troubles when displaying multiple optimized SVGs on one page.

  Please be aware that SVGO can break your svg. You'll find more info on that in [this excellent blogpost](https://www.sarasoueidan.com/blog/svgo-tools/) by [Sara Soueidan](https://twitter.com/SaraSoueidan).
  """

  alias ExOptimizer.{Image, Optimizer}

  @behaviour Optimizer
  @mimes ["text/html", "image/svg", "image/svg+xml", "text/plain"]
  @options ["--disable={cleanupIDs,removeViewBox}"]
  @binary_name "svgo"

  @impl Optimizer
  def can_handle(%Image{mime: mime, ext: extension}),
    do: extension == ".svg" && mime in @mimes

  @impl Optimizer
  def binary_name(), do: @binary_name

  @impl Optimizer
  def extra_args(%Image{path: path} = _image), do: ["--output=#{path}"]

  @impl Optimizer
  def options(), do: @options
end
