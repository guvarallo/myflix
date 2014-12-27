class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  default_scope { order('position') }

  validates_numericality_of :position, {only_integer: true}

  def rating
    review.rating if review.present?
  end

  def rating=(new_rating)
    if review.present?
      review.update_column(:rating, new_rating)
    else
      review = Review.new(user_id: user.id, video_id: video.id, rating: new_rating)
      review.save(validate: false)
    end
  end

  private

  def review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end
end
