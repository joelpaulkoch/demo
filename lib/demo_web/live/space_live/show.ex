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
     |> assign(:space, Spaces.get_space_by_name!(name))}
  end

  defp page_title(:show), do: "Show Space"
end
