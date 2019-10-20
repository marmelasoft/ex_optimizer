defmodule ExOptimizer.Image do
  @moduledoc """
  Represents a picture
  """

  @type path :: binary
  @type ext :: binary
  @type mime :: binary

  @type t :: %__MODULE__{
          path: path,
          ext: ext,
          mime: mime
        }

  defstruct path: nil,
            ext: nil,
            mime: nil
end
