module ApplicationHelper

  def avarage_rating
    p = @video.reviews.pluck(:rating)
    sum_of_all_ratings = p.inject(:+)
    avarage = sum_of_all_ratings / @video.reviews.count
    return avarage
  end

end
