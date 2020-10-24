defmodule ExOptimizer.Optimizer do
  @moduledoc """
  Behaviour for creating ExOptimizer optimizers.

  The current list of optimizers bundled with ExOptimizer are the following:
   * JPEG files
     * `ExOptimizer.Optimizers.JpegOptim`
   * PNG files
     * `ExOptimizer.Optimizers.PngQuant`
     * `ExOptimizer.Optimizers.Optipng`
   * SVG files
     * `ExOptimizer.Optimizers.Svgo`
   * GIF files
     * `ExOptimizer.Optimizers.Gifsicle`
   * WebP files
     * `ExOptimizer.Optimizers.Cwebp`

  ## Example

      defmodule ExOptimizer.Optimizers.Custom do
        @behaviour ExOptimizer.Optimizer

        def binary_name(), do: "some_command"

        def can_handle(%Image{path: path, ext: ext, mime: mime} = _image), do: mime == "image/something"

        def extra_args(%Image{path: path} = _image), do: ["-o \#{path}"]

        def options(), do: ["--force", "--produce 'best'"]
      end
  """

  alias ExOptimizer.Image

  @callback binary_name :: String.t()

  @callback can_handle(Image.t()) :: boolean

  @callback extra_args(Image.t()) :: list(String.t())

  @callback options :: list(String.t())
end
