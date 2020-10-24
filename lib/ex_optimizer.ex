defmodule ExOptimizer do
  @moduledoc """
  ExOptimizer is a tool to optimize pictures by running them through a chain of various image optimization tools.
  """

  alias ExOptimizer.Image
  alias ExOptimizer.Optimizers.{Cwebp, Gifsicle, JpegOptim, Optipng, PngQuant, Svgo}

  @default_optimizers [
    JpegOptim,
    PngQuant,
    Optipng,
    Svgo,
    Gifsicle,
    Cwebp
  ]

  @doc """
  Optimize a picture

  Options:
   * `optimizers` accepts a list of optimizers (see `ExOptimizer.Optimizer`) module names or tuples with the module name and the custom options to pass to the binary command.
  """
  @spec optimize(String.t(), List.t()) ::
          {:ok, Map.t()} | {:error, Map.t()} | {:error, :file_not_found}
  def optimize(path, opts \\ []) do
    path = Path.expand(path)

    case {:regular_file, File.regular?(path)} do
      {:regular_file, true} ->
        image = load_image(path)

        optimizers =
          opts
          |> Keyword.get(:optimizers, @default_optimizers)
          |> find_optimizers()

        res =
          Enum.reduce(optimizers, %{}, fn {optimizer_module, _optimizer_options} = optimizer,
                                          acc ->
            Map.put(acc, optimizer_module, do_optimize(image, optimizer))
          end)

        status =
          if Enum.all?(res, &is_status_ok/1),
            do: :ok,
            else: :error

        {status, res}

      {:regular_file, false} ->
        {:error, :file_not_found}
    end
  end

  @spec do_optimize(Image.t(), {atom(), list()}) :: tuple()
  defp do_optimize(%Image{path: path} = image, {optimizer, optimizer_options}) do
    with {:can_handle, true} <- {:can_handle, optimizer.can_handle(image)},
         {:module_not_found, {:module, _module}} <-
           {:module_not_found, Code.ensure_compiled(optimizer)},
         {:executable_not_found, executable_path} when is_binary(executable_path) <-
           {:executable_not_found, System.find_executable(optimizer.binary_name())},
         args <- optimizer_options ++ optimizer.extra_args(image) ++ [path],
         {:error_command, {_return, 0} = res} <-
           {:error_command, System.cmd(optimizer.binary_name(), args)} do
      {:ok, res}
    else
      {:can_handle, false} -> {:ignore, :not_applicable}
      {:error_command, res} -> {:error, :command, res}
      {:executable_not_found, nil} -> {:ignore, :executable_not_found}
      {:module_not_found, _} -> {:error, :module_not_loaded}
    end
  end

  @spec find_optimizers(List.t()) :: List.t()
  defp find_optimizers(optimizers), do: Enum.map(optimizers, &make_optimizer_config/1)

  @spec make_optimizer_config(tuple()) :: tuple()
  defp make_optimizer_config({optimizer, config}), do: {optimizer, config}

  @spec make_optimizer_config(atom()) :: tuple()
  defp make_optimizer_config(optimizer), do: {optimizer, optimizer.options()}

  @spec load_image(String.t()) :: Image.t()
  defp load_image(path) do
    infos = FileInfo.get_info(path)
    %FileInfo.Mime{subtype: subtype, type: type} = Map.get(infos, path)

    %Image{path: path, ext: Path.extname(path), mime: "#{type}/#{subtype}"}
  end

  defp is_status_ok({_, {status, _}}) when status in [:ok, :ignore], do: true
  defp is_status_ok({_, {status, _, _}}) when status in [:ok, :ignore], do: true
  defp is_status_ok(_), do: false
end
