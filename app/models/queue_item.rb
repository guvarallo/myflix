class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  default_scope { order('position') }

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review.present?
  end

end
