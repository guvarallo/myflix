Fabricator(:review) do
  body { Faker::Lorem.paragraph(8) }
  rating { rand(1...6) }
  user_id { User.pluck(:id).shuffle.first }
  video_id { Video.pluck(:id).shuffle.first }
end