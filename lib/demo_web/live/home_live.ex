defmodule DemoWeb.HomeLive do
  use DemoWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <.flash_group flash={@flash} />

    <div class="flex flex-col items-center">
      <main class="flex-1">
        <section class="w-full">
          <div class="grid items-center justify-center gap-6 px-4 py-12 md:grid-cols-2 md:px-6 md:py-24 lg:gap-12 lg:px-12 xl:gap-24">
            <div class="flex flex-col items-start space-y-4">
              <div class="space-y-2">
                <h1 class="text-3xl font-bold tracking-tighter sm:text-4xl md:text-5xl lg:text-6xl/none">
                  <%= gettext("Run this magic demo") %>
                </h1>
                <p class="text-base tracking-wide text-gray-500 dark:text-gray-400">
                  <%= gettext("Enjoy some cool stuff") %>
                </p>
              </div>
              <.button phx-click="open_space">
                <%= gettext("Let's go") %>
              </.button>
            </div>
            <div class="aspect-video max-w-64 mx-auto ">
              <img
                src={~p"/images/logo.svg"}
                width="256"
                height="256"
                alt="Image"
                class="object-scale-down object-center"
              />
            </div>
          </div>
        </section>
        <section class="w-full border-t py-12 md:py-24 lg:py-32">
          <div class="container grid items-center justify-center gap-4 px-4 text-center md:px-6">
            <div class="space-y-3">
              <h2 class="text-3xl font-bold tracking-tighter md:text-4xl/tight">
                <%= gettext("Get the news") %>
              </h2>
              <p class="max-w-[600px] mx-auto text-gray-500 dark:text-gray-400 md:text-xl/relaxed lg:text-base/relaxed xl:text-xl/relaxed">
                <%= gettext("Sign up here") %>
              </p>
            </div>
            <div class="mx-auto w-full max-w-sm space-y-2">
              <form class="flex space-x-2">
                <input
                  class="border-input bg-background ring-offset-background flex h-10 w-full max-w-lg flex-1 rounded-md border px-3 py-2 text-sm file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:ring-ring focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                  placeholder={gettext("Enter your email")}
                  type="email"
                />
                <.button type="submit">
                  <%= gettext("Sign Up") %>
                </.button>
              </form>
              <p class="text-xs text-gray-500 dark:text-gray-400">
                <%= gettext("Sign up to get notified when we launch.") %>
              </p>
            </div>
          </div>
        </section>
      </main>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    assign(socket, :page_title, "Home")
  end

  @impl true
  def handle_event("open_space", _params, socket) do
    space_name = get_unique_space_name()

    {:ok, space} = Demo.Spaces.create_space(%{name: space_name})

    {:noreply, push_navigate(socket, to: ~p"/spaces/#{space.name}")}
  end

  defp get_unique_space_name() do
    color = Faker.Color.fancy_name()
    cat = Faker.Cat.name()
    space_name = color <> cat

    case Demo.Spaces.get_space_by_name!(space_name) do
      nil -> space_name
      _ -> get_unique_space_name()
    end
  end
end
