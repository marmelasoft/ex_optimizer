defmodule ExOptimizer.Optimizers.JpegOptim do
  @moduledoc """
  [JpegOptim](https://github.com/tjko/jpegoptim) is a tool to optimize JPEG files

  The following options are used by default:
    * `-m85`: this will store the image with 85% quality. This setting [seems to satisfy Google's Pagespeed compression rules](https://webmasters.stackexchange.com/questions/102094/google-pagespeed-how-to-satisfy-the-new-image-compression-rules)
    * `--strip-all`: this strips out all text information such as comments and EXIF data
    * `--all-progressive`: this will make sure the resulting image is a progressive one, meaning it can be downloaded using multiple passes of progressively higher details.
  """

  alias ExOptimizer.{Image, Optimizer}

  @behaviour Optimizer
  @mime "image/jpeg"
  @options ["-m85", "--strip-all", "--all-progressive"]
  @binary_name "jpegoptim"

  @impl Optimizer
  def can_handle(%Image{mime: mime}), do: mime == @mime

  @impl Optimizer
  def binary_name(), do: @binary_name

  @impl Optimizer
  def extra_args(%Image{} = _image), do: []

  @impl Optimizer
  def options(), do: @options
end
