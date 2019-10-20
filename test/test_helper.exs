defmodule ExOptimizerTest.TestHelper do
  require Logger
  @temp_dir "test/temp"

  def empty_temp_directory() do
    with {:ok, files} <- File.ls(@temp_dir) do
      Enum.each(files, fn file ->
        if file != ".gitkeep" do
          file_path = Path.join(@temp_dir, file)
          File.rm(file_path)
        end
      end)
    end
  end

  @spec copy_file_temp(String.t()) :: String.t()
  def copy_file_temp(file) do
    source = Path.join("test/fixtures/", file)
    destination = Path.join("test/temp", file)

    with :ok <- File.cp(source, destination) do
      destination
    end
  end

  def test_file_path(file) do
    Path.join("test/fixtures/", file)
  end

  def file_size(file_path) do
    with {:ok, %File.Stat{size: size}} <- File.stat(file_path) do
      size
    end
  end
end

ExOptimizerTest.TestHelper.empty_temp_directory()
ExUnit.start()
