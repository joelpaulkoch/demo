defmodule DemoWeb.RestoreLocale do
  def on_mount(:default, %{"locale" => locale}, _session, socket) do
    if locale in Gettext.known_locales(DemoWeb.Gettext) do
      Gettext.put_locale(DemoWeb.Gettext, locale)
    else
      Gettext.put_locale(DemoWeb.Gettext, "en")
    end

    {:cont, socket}
  end

  # catch-all case
  def on_mount(:default, _params, _session, socket), do: {:cont, socket}
end
