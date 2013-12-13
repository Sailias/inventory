# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ebay = Ebay::Api.new

# => Motors Category is 6000
response = ebay.get_categories(
  detail_level: 'ReturnAll',
  category_parents: ["6000"],
  level_limit: 3
)

response.categories.each do |c|
  parent = Category.where(ebay_categoryid: c.category_parent_ids.first).first
  Category.create(name: c.category_name, ebay_categoryid: c.category_id, parent: parent)
end


