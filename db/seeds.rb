# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "Monk", description: "Monk movie", large_cover_url: "/tmp/monk_large.jpg", small_cover_url: "/tmp/monk.jpg")
Video.create(title: "Family Guy", description: "Family guy moive", small_cover_url: "/tmp/family_guy.jpg")
Video.create(title: "Futurama", description: "Futurama movie", small_cover_url: "/tmp/futurama.jpg")
Category.create(name: "Comedy")
Category.create(name: "Drama")
Category.create(name: "Suspense")
Category.create(name: "Action")
