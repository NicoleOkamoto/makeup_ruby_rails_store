Deface::Override.new(
  virtual_path: 'spree/shared/_header',
  name: 'replace_logo',
  replace: 'erb[loud]:contains("logo")', # Adjust this selector to match the logo element in the original view
  text:
   "<%= image_tag('store/eleve_logo.png', alt: 'Eleve Store Logo') %>"
)
