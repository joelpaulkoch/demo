defmodule DemoWeb.SpaceLive.Show do
  use DemoWeb, :live_view

  alias Demo.Spaces

  @impl true
  def mount(%{"name" => name}, _session, socket) do
    Phoenix.PubSub.subscribe(Demo.PubSub, "space:#{name}")
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"name" => name}, _, socket) do
    space =
      Spaces.get_space_by_name!(name)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:space, space)
     |> assign(:image, image_from_s3(space.image))}
  end

  defp page_title(:show), do: "Show Space"

  def image_from_s3(nil), do: nil

  def image_from_s3(image) do
    {:ok, image_url} =
      :s3
      |> ExAws.Config.new([])
      |> ExAws.S3.presigned_url(:get, "demo-magic", image, [])

    image_url
  end

  @impl Phoenix.LiveView
  def handle_event("update", _params, socket) do
    image = Enum.random(["magic0.webp", "magic1.webp"])

    {:ok, _space} = Spaces.update_space(socket.assigns.space, %{image: image})

    {:noreply, socket}
  end

  @impl true
  def handle_info({:space_update, %{image: image}}, socket) do
    {:noreply, assign(socket, :image, image_from_s3(image))}
  end
end
