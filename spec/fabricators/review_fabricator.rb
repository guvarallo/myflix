Fabricator(:review) do
  body { Faker::Lorem.paragraph(8) }
  rating { rand(1...6) }
  # Ask later why the below doesn't work, and how should it be done
  # user.id { User.pluck(:id).shuffle.first }
  # video.id { Video.pluck(:id).shuffle.first) }
end