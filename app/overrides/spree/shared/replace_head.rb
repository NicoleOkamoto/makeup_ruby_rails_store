Deface::Override.new(
  virtual_path: 'spree/shared/_head',
  name: 'replace_head',
  replace: 'erb[loud]:contains("logo")', # Adjust this selector to match the logo element in the original view
  text: <<-HTML
    <%= link_to root_path do %>
      <%= image_tag('store/eleve_logo.png', alt: 'Eleve Store Logo') %>
    <% end %>
  HTML
)
