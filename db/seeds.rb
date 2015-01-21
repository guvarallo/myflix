# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times { Fabricate(:user) }
Category.create(name: "Comedy")
Category.create(name: "Drama")
Category.create(name: "Suspense")
Video.create(category_id: 1, title: "Monk", description: "Monk movie", large_cover_url: "/tmp/monk_large.jpg", small_cover_url: "/tmp/monk.jpg")
Video.create(category_id: 2, title: "Family Guy", description: "Family guy moive", large_cover_url: "/tmp/family_guy.jpg", small_cover_url: "/tmp/family_guy.jpg")
Video.create(category_id: 3, title: "Futurama", description: "Futurama movie", large_cover_url: "/tmp/futurama.jpg", small_cover_url: "/tmp/futurama.jpg")
Video.create(category_id: 1, title: "Monk", description: "Monk movie", large_cover_url: "/tmp/monk_large.jpg", small_cover_url: "/tmp/monk.jpg")
Video.create(category_id: 2, title: "Family Guy", description: "Family guy moive", large_cover_url: "/tmp/family_guy.jpg", small_cover_url: "/tmp/family_guy.jpg")
Video.create(category_id: 3, title: "Futurama", description: "Futurama movie", large_cover_url: "/tmp/futurama.jpg", small_cover_url: "/tmp/futurama.jpg")
Video.create(category_id: 1, title: "Monk", description: "Monk movie", large_cover_url: "/tmp/monk_large.jpg", small_cover_url: "/tmp/monk.jpg")
Video.create(category_id: 2, title: "Family Guy", description: "Family guy moive", large_cover_url: "/tmp/family_guy.jpg", small_cover_url: "/tmp/family_guy.jpg")
Video.create(category_id: 3, title: "Futurama", description: "Futurama movie", large_cover_url: "/tmp/futurama.jpg", small_cover_url: "/tmp/futurama.jpg")
50.times { Fabricate(:review) }
