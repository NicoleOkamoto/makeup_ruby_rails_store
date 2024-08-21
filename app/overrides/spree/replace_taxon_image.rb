Deface::Override.new(
  virtual_path: 'spree/products/index',
  name: 'replace_taxon_image',
  replace_contents: "div#no-taxon-banner img[src*='products.jpg']",
  text: <<~HTML
    <div id="no-taxon-banner">
      <div class="container">
        <%= lazy_image(
          src: asset_path('homepage/new-banner.jpg'),
          alt: 'new-banner',
          width: 1110,
          height: 300,
          class: 'w-100 d-none d-md-block'
        ) %>
      </div>
    </div>
  HTML
)
