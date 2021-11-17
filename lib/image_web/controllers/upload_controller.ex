defmodule ImageWeb.UploadController do
  use ImageWeb, :controller

  alias Image.Uploads.Upload
  alias Image.Uploads
  alias Image.Repo
  alias ImageWeb.UploadView

  action_fallback ImageWeb.FallbackController


  # This fuction is used for upload new image to AWS S3
  def create(conn, %{"image" => upload_params}) do

    {:ok, image_binary} = File.read(upload_params["image_url"])

    bucket_name = System.get_env("BUCKET_NAME")

    s3_path = "/images"

    image =
      ExAws.S3.put_object(bucket_name, s3_path, image_binary)
      |> ExAws.request!

    # build the image url and add to the params to be stored
    updated_params =
      upload_params
      |> Map.update(image, upload_params, fn _value -> "https://#{bucket_name}.s3.amazonaws.com/#{bucket_name}/#{s3_path}" end)

    changeset = Upload.changeset(%Upload{}, updated_params)

    case Repo.insert!(changeset) do
       changeset ->
        conn
        |> put_status(200)
        |> render("show.json", %{upload: "image uploaded successfully"})

      error ->
        error
      end

  end



  # This function for list the images in AWS S3-Buckets
  def list_buckets(conn, _params) do
    case Uploads.get_buckets() do
      images ->
        conn
        |> put_status(200)
        |> render("list.json", %{images: images})

      error ->
        error
    end
  end


  # This function for download the image from AWS S3-Bucket
  def download_image(conn, params) do
    case Uploads.get_image(params["key"]) |> IO.inspect() do
      uploads ->

        conn
        |> put_status(200)
        |> render("show.json", %{upload: "image downloaded successfully"})

      error ->
        error
    end
  end


end
