defmodule ExOptimizerTest do
  use ExUnit.Case
  doctest ExOptimizer
  alias ExOptimizer.Optimizers.{Cwebp, Gifsicle, JpegOptim, Optipng, PngQuant, Svgo}
  import ExOptimizerTest.TestHelper

  @jpeg_file "image.jpg"
  @png_file "logo.png"
  @svg_file "graph.svg"
  @gif_file "animated.gif"
  @webp_file "image.webp"

  def assert_decreased_file_size(modified_file_path, original_file_path) do
    assert File.exists?(modified_file_path)
    assert File.exists?(original_file_path)

    assert(
      file_size(modified_file_path) < file_size(original_file_path),
      "File #{modified_file_path} hasn't got a size less than #{original_file_path}"
    )
  end

  setup_all do
    on_exit(&empty_temp_directory/0)
  end

  test "Optimizes a JPEG file with all optimizers" do
    jpeg_temp_file = copy_file_temp(@jpeg_file)

    assert {:ok,
            %{
              JpegOptim => {:ok, {res, 0}},
              Optipng => {:ignore, :not_applicable},
              PngQuant => {:ignore, :not_applicable},
              Gifsicle => {:ignore, :not_applicable},
              Svgo => {:ignore, :not_applicable},
              Cwebp => {:ignore, :not_applicable}
            }} = ExOptimizer.optimize(jpeg_temp_file)

    assert res =~ "test/temp/image.jpg"
    assert res =~ "[OK] 547241 --> 483002 bytes (11.74%), optimized.\n"
    assert_decreased_file_size(jpeg_temp_file, test_file_path(@jpeg_file))
  end

  test "Optimizes a PNG file with all optimizers" do
    png_file = copy_file_temp(@png_file)

    assert {:ok,
            %{
              JpegOptim => {:ignore, :not_applicable},
              Optipng => {:ok, {"", 0}},
              PngQuant => {:ok, {"", 0}},
              Gifsicle => {:ignore, :not_applicable},
              Svgo => {:ignore, :not_applicable},
              Cwebp => {:ignore, :not_applicable}
            }} == ExOptimizer.optimize(png_file)

    assert_decreased_file_size(png_file, test_file_path(@png_file))
  end

  test "Optimizes a SVG file with all optimizers" do
    svg_file = copy_file_temp(@svg_file)

    assert {:ok,
            %{
              JpegOptim => {:ignore, :not_applicable},
              Optipng => {:ignore, :not_applicable},
              PngQuant => {:ignore, :not_applicable},
              Gifsicle => {:ignore, :not_applicable},
              Svgo => {:ok, {res, 0}}
            }} = ExOptimizer.optimize(svg_file)

    assert res =~ "\ngraph.svg:\nDone"
    assert res =~ "24.986 KiB - 23.4% = 19.134 KiB"
    assert_decreased_file_size(svg_file, test_file_path(@svg_file))
  end

  test "Optimizes a GIF file with all optimizers" do
    gif_file = copy_file_temp(@gif_file)

    assert {:ok,
            %{
              JpegOptim => {:ignore, :not_applicable},
              Optipng => {:ignore, :not_applicable},
              PngQuant => {:ignore, :not_applicable},
              Gifsicle => {:ok, {"", 0}},
              Svgo => {:ignore, :not_applicable},
              Cwebp => {:ignore, :not_applicable}
            }} == ExOptimizer.optimize(gif_file)

    assert_decreased_file_size(gif_file, test_file_path(@gif_file))
  end

  test "Optimizes a WebP file with all optimizers" do
    webp_file = copy_file_temp(@webp_file)

    assert {:ok,
            %{
              JpegOptim => {:ignore, :not_applicable},
              Optipng => {:ignore, :not_applicable},
              PngQuant => {:ignore, :not_applicable},
              Gifsicle => {:ignore, :not_applicable},
              Svgo => {:ignore, :not_applicable},
              Cwebp => {:ok, {"", 0}}
            }} == ExOptimizer.optimize(webp_file)

    assert_decreased_file_size(webp_file, test_file_path(@webp_file))
  end

  test "Optimizes a PNG file with only PNG optimizers" do
    png_file = copy_file_temp(@png_file)

    assert {:ok,
            %{
              Optipng => {:ok, {"", 0}},
              PngQuant => {:ok, {"", 0}}
            }} == ExOptimizer.optimize(png_file, optimizers: [Optipng, PngQuant])

    assert_decreased_file_size(png_file, test_file_path(@png_file))
  end

  test "Optimizes a PNG file with only PNG optimizers and good config" do
    png_file = copy_file_temp(@png_file)

    assert {:ok,
            %{
              Optipng => {:ok, {"", 0}},
              PngQuant => {:ok, {"", 0}}
            }} == ExOptimizer.optimize(png_file, optimizers: [Optipng, {PngQuant, ["--force"]}])

    assert_decreased_file_size(png_file, test_file_path(@png_file))
  end

  test "Optimizes a PNG file with only PNG optimizers and bad config will return error" do
    png_file = copy_file_temp(@png_file)

    assert {:error,
            %{
              Optipng => {:ok, {"", 0}},
              PngQuant => {:error, :command, {"", 4}}
            }} == ExOptimizer.optimize(png_file, optimizers: [Optipng, {PngQuant, ["--speed 3"]}])

    assert_decreased_file_size(png_file, test_file_path(@png_file))
  end
end
