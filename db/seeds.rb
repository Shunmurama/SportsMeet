# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.create!(
  email: "admin1@example.com",
  password: "123456"
)


# カテゴリー初期設定
Category.find_or_create_by!(name: "野球") do |category|
  category.name = "野球"
end

Category.find_or_create_by!(name: "ソフトボール") do |category|
  category.name = "ソフトボール"
end

Category.find_or_create_by!(name: "サッカー") do |category|
  category.name = "サッカー"
end

Category.find_or_create_by!(name: "マラソン") do |category|
  category.name = "マラソン"
end

Category.find_or_create_by!(name: "テニス") do |category|
  category.name = "テニス"
end

Category.find_or_create_by!(name: "バドミントン") do |category|
  category.name = "バドミントン"
end

