namespace :import do
  desc "Import products from API to Spree"
  task products: :environment do
    require 'net/http'
    require 'json'

    # Fetch data from the API
    url = 'https://makeup-api.herokuapp.com/api/v1/products.json'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    products = JSON.parse(response)

    # Define or find necessary categories
    tax_category = Spree::TaxCategory.find_or_create_by(name: 'Default Tax Category')
    shipping_category = Spree::ShippingCategory.find_or_create_by(name: 'Default Shipping Category')

    # Define the store
    store = Spree::Store.find_by(id: 1)
    unless store
      puts "Store with ID 1 not found. Please create or verify the store."
      exit
    end

    # Process each product
    products.each do |product_data|
      next unless product_data['name'] && product_data['price'] && product_data['image_link']

      # Create or update the product
      spree_product = Spree::Product.find_or_initialize_by(name: product_data['name'])
      spree_product.assign_attributes(
        description: product_data['description'],
        price: product_data['price'].to_f,
        available_on: Time.now,
        slug: product_data['name'].parameterize,
        currency: 'CAD',
        tax_category_id: tax_category.id,
        shipping_category_id: shipping_category.id,
        promotionable: true,
        status: 'active'
      )

      spree_product.store = Spree::Store.find_by(default: true)
      spree_product.save!

      if spree_product.save
        # Associate the product with the store
        unless spree_product.stores.include?(store)
          spree_product.stores << store
          spree_product.save
        end
        puts "Product '#{spree_product.name}' created or updated successfully."
      else
        puts "Failed to save product '#{spree_product.name}'. Errors: #{spree_product.errors.full_messages.join(', ')}"
      end
    end
  end
end
