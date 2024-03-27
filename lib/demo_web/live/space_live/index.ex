defmodule DemoWeb.SpaceLive.Index do
  use DemoWeb, :live_view

  alias Demo.Spaces
  alias Demo.Spaces.Space

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :spaces, Spaces.list_spaces())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Space")
    |> assign(:space, %Space{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Spaces")
    |> assign(:space, nil)
  end

  @impl true
  def handle_info({DemoWeb.SpaceLive.FormComponent, {:saved, space}}, socket) do
    {:noreply, stream_insert(socket, :spaces, space)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    space = Spaces.get_space!(id)
    {:ok, _} = Spaces.delete_space(space)

    {:noreply, stream_delete(socket, :spaces, space)}
  end
end
