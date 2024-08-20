# db/seeds/zones.rb

# List of Canadian provinces and territories
provinces = [
  'Alberta', 'British Columbia', 'Manitoba', 'New Brunswick', 'Newfoundland and Labrador',
  'Northwest Territories', 'Nova Scotia', 'Nunavut', 'Ontario', 'Prince Edward Island',
  'Quebec', 'Saskatchewan', 'Yukon'
]

# Create a zone for each province/territory
provinces.each do |province|
  Spree::Zone.create!(name: "Canada - #{province}", description: "#{province} Zone", kind: "state")
end

puts "Zones for Canadian provinces have been created."
