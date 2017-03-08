# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

product_list = [
  [ "banana", 2, "banana_image", "This is a banana" ],
  [ "nerf gun", 25, "nerf_gun_image", "This is a nerf gun"]
]

product_list.each do |product|
  Product.create( :name => product[0], :price => product[1], :image => product[2], :description => product[3] )
end