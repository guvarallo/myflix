module ApplicationHelper

  def avarage_rating
    p = @video.reviews.pluck(:rating)
    sum_of_all_ratings = p.inject(:+)
    avarage = sum_of_all_ratings / @video.reviews.count
    return avarage
  end

  def queue_items_rating_options(selected=nil)
    options_for_select([5,4,3,2,1].map {|number| [pluralize(number, "Star"), number]}, selected)
  end

end
