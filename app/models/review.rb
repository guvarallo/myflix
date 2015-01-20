class Review < ActiveRecord::Base

  belongs_to :user, dependent: :destroy
  belongs_to :video

  validates_presence_of :body, :rating
end
