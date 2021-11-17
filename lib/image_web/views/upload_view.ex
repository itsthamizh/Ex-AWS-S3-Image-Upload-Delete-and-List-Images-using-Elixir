defmodule ImageWeb.UploadView do
  use ImageWeb, :view
  alias ImageWeb.UploadView

  def render("index.json", %{uploads: uploads}) do
    %{data: render_many(uploads, UploadView, "upload.json")}
  end

  def render("list.json", %{images: images}) do
    %{
      image_info: images.body.contents
    }
  end

  def render("show.json", %{upload: upload}) do
    %{data: render_one(upload, UploadView, "upload.json")}
  end

  def render("upload.json", %{upload: upload}) do
    %{
      message: upload
    }
  end

end
