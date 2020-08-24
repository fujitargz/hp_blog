# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# メインのサンプルユーザを一人作成する
User.create!(name: "Default Admin", password: "kougakusai2020", password_confirmation: "kougakusai2020", admin: true)
User.create!(name: "Example Admin", password: "password", password_confirmation: "password", admin: true)
User.create!(name: "Example User", password: "password", password_confirmation: "password")
