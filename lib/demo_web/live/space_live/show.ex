defmodule DemoWeb.SpaceLive.Show do
  use DemoWeb, :live_view

  alias Demo.Spaces

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"name" => name}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:space, Spaces.get_space_by_name!(name))
     |> assign(:image, image_from_s3("magic0.webp"))}
  end

  defp page_title(:show), do: "Show Space"

  def image_from_s3(image) do
    {:ok, image_url} =
      :s3
      |> ExAws.Config.new([])
      |> ExAws.S3.presigned_url(:get, "demo-magic", image, [])

    image_url
  end
end
