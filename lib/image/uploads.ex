defmodule Image.Uploads do
  @moduledoc """
  The Uploads context.
  """

  import Ecto.Query, warn: false
  alias Image.Repo

  alias Image.Uploads.Upload


  def get_buckets() do
    buckets =
      ExAws.S3.list_objects("")
      |> ExAws.request!()
  end


  def get_image(key) do
    resp =
      ExAws.S3.get_object("", "#{key}")
      |> ExAws.request!()

    File.write!("downloaded_image.png", resp.body)

  end

end
