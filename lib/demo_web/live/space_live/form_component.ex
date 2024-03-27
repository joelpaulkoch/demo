defmodule DemoWeb.SpaceLive.FormComponent do
  use DemoWeb, :live_component

  alias Demo.Spaces

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage space records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="space-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Space</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{space: space} = assigns, socket) do
    changeset = Spaces.change_space(space)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"space" => space_params}, socket) do
    changeset =
      socket.assigns.space
      |> Spaces.change_space(space_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"space" => space_params}, socket) do
    save_space(socket, socket.assigns.action, space_params)
  end

  defp save_space(socket, :edit, space_params) do
    case Spaces.update_space(socket.assigns.space, space_params) do
      {:ok, space} ->
        notify_parent({:saved, space})

        {:noreply,
         socket
         |> put_flash(:info, "Space updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_space(socket, :new, space_params) do
    case Spaces.create_space(space_params) do
      {:ok, space} ->
        notify_parent({:saved, space})

        {:noreply,
         socket
         |> put_flash(:info, "Space created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
