# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'net/http'
require 'json'
require 'open-uri'

# Load default Spree seeds if they exist
Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

# Ensure the store with ID 1 exists
store = Spree::Store.find_by(id: 1)
unless store
  puts "Store with ID 1 not found. Please create or verify the store."
  exit
end

# Find or create tax categories and shipping categories
tax_category = Spree::TaxCategory.find_by(id: 1)
unless tax_category
  puts "Tax Category with ID 1 not found. Please create or verify the tax category."
  exit
end

shipping_category = Spree::ShippingCategory.find_by(id: 1)
unless shipping_category
  puts "Shipping Category with ID 1 not found. Please create or verify the shipping category."
  exit
end

# Ensure the stock location exists
stock_location = Spree::StockLocation.find_or_create_by!(name: 'default') do |location|
  location.active = true
  location.default = true
  location.backorderable_default = true
  location.propagate_all_variants = true
end

# Fetch data from Makeup API
url = 'https://makeup-api.herokuapp.com/api/v1/products.json'
uri = URI(url)
response = Net::HTTP.get(uri)
products = JSON.parse(response)

# Define the number of products to seed
products_to_seed = products.first(10)

# Loop through each product from the API and create/update it in Spree
products_to_seed.each do |product_data|
  # Skip products without necessary fields
  next unless product_data['name'].present? && product_data['price'].present? && product_data['image_link'].present?

    # Convert price to a float
    price = product_data['price'].to_f

    # Only create the product if the price is greater than 0.00
    next if price <= 0.00

  spree_product = Spree::Product.find_or_initialize_by(name: product_data['name'])

  spree_product.assign_attributes(
    description: product_data['description'],
    price: product_data['price'],
    available_on: Time.now,
    slug: product_data['name'].parameterize,
    currency: 'CAD',
    tax_category_id: tax_category.id,
    shipping_category_id: shipping_category.id,
    promotionable: true,
    status: 'active',
  )

  # Skip validation temporarily to avoid the store association issue
  spree_product.save(validate: false)

  if spree_product.persisted?
    puts "Created/Updated product #{spree_product.name}"

    # Associate product with store
    store_product = Spree::StoreProduct.find_or_initialize_by(store: store, product: spree_product)
    if store_product.save
      puts "Successfully associated product #{spree_product.name} with store #{store.name}"
    else
      puts "Failed to associate product #{spree_product.name} with store #{store.name}: #{store_product.errors.full_messages.join(', ')}"
    end

    # Set inventory quantity for the product
    variant = spree_product.master
    stock_item = stock_location.stock_items.find_or_initialize_by(variant: variant)
    stock_item.set_count_on_hand(100) # Set the quantity here
    stock_item.save!
    puts "Set inventory quantity for product #{spree_product.name} to 100"


# Download and attach the image

image_url = product_data['api_featured_image']
# Ensure URL has the correct scheme
unless image_url.start_with?('http://', 'https://')
  image_url = "https:#{image_url}"
end

# Debugging print
puts "Attempting to download image from: #{image_url}"

begin
  image_file = URI.open(image_url)
  spree_image = spree_product.images.new
  spree_image.attachment.attach(io: image_file, filename: "#{spree_product.slug}.jpg")
  spree_image.save
  puts "Image attached to product #{spree_product.name}"
rescue OpenURI::HTTPError => e
  puts "HTTP Error while downloading image for product #{spree_product.name}: #{e.message}"
rescue Errno::ENOENT => e
  puts "File Error while attaching image for product #{spree_product.name}: #{e.message}"
rescue => e
  puts "Failed to download or attach image for product #{spree_product.name}: #{e.message}"
end

puts "Image URL: #{image_url}"

if image_url.blank? || !image_url.start_with?('http://', 'https://')
  puts "Skipping image for product #{spree_product.name} due to invalid URL"
  next
end

  else
    puts "Failed to create/update product #{spree_product.name}: #{spree_product.errors.full_messages.join(', ')}"
  end
end



# require 'net/http'
# require 'json'
# require 'open-uri'



# # Fetch data from Makeup API
# url = 'https://makeup-api.herokuapp.com/api/v1/products.json'
# uri = URI(url)
# response = Net::HTTP.get(uri)
# products = JSON.parse(response)

# store = Spree::Store.find(1)
# if store.nil?
#   puts "Store with ID 1 not found"
#   exit
# end

# shipping_category = Spree::ShippingCategory.find_by(id: 1) || Spree::ShippingCategory.create(name: "Default Shipping Category")
# tax_category = Spree::TaxCategory.find_by(id: 1) || Spree::TaxCategory.create(name: "Default Tax Category")

# products_to_seed = products.first(10)


# # Loop through each product and create it in Spree
# products_to_seed.each do |product|
#   spree_product = Spree::Product.new(
#     name: product['name'],
#     description: product['description'],
#     price: product['price'],
#     available_on: Time.now,
#     slug: product['name'].parameterize,
#     currency: 'CAD',
#     tax_category_id: tax_category.id,
#     shipping_category_id: shipping_category.id,
#     promotionable: true,
#     status: "active",


#   )


#   # Attempt to save the product and check for errors
#   if spree_product.save
#     puts "Created product: #{spree_product.name}"

#     # Add image if available
#     if product['image_link'].present?
#       spree_image = spree_product.images.new
#       spree_image.attachment.attach(io: URI.open(product['image_link']), filename: "#{spree_product.slug}.jpg")
#       spree_image.save
#     end
#   else
#     puts "Failed to create product: #{spree_product.name}"
#     spree_product.errors.full_messages.each do |error|
#       puts "  Error: #{error}"
#     end
#   end
# end


# {
#   "data": {
#     "id": "168",
#     "type": "product",
#     "attributes": {
#       "name": "Spinning Top",
#       "description": null,
#       "available_on": null,
#       "deleted_at": null,
#       "slug": "spinning-top",
#       "meta_description": null,
#       "meta_keywords": null,
#       "created_at": "2022-11-08T19:34:53.239Z",
#       "updated_at": "2022-11-08T19:34:53.243Z",
#       "promotionable": true,
#       "meta_title": null,
#       "discontinue_on": null,
#       "public_metadata": {},
#       "private_metadata": {},
#       "status": "draft",
#       "make_active_at": null,
#       "display_compare_at_price": null,
#       "display_price": "$87.43",
#       "purchasable": false,
#       "in_stock": false,
#       "backorderable": false,
#       "available": false,
#       "currency": "USD",
#       "price": "87.43",
#       "compare_at_price": null
#     },
#     "relationships": {
#       "tax_category": {
#         "data": null
#       },
#       "primary_variant": {
#         "data": {
#           "id": "235",
#           "type": "variant"
#         }
#       },
#       "default_variant": {
#         "data": {
#           "id": "235",
#           "type": "variant"
#         }
#       },
#       "variants": {
#         "data": []
#       },
#       "option_types": {
#         "data": []
#       },
#       "product_properties": {
#         "data": []
#       },
#       "taxons": {
#         "data": []
#       },
#       "images": {
#         "data": []
#       }
#     }
#   }
# }
