defmodule Image.Uploads.Upload do
  use Ecto.Schema
  import Ecto.Changeset

  schema "uploads" do
    field :image_url, :string

    timestamps()
  end

  @doc false
  def changeset(upload, attrs) do
    upload
    |> cast(attrs, [:image_url])
    |> validate_required([:image_url])
  end

end
