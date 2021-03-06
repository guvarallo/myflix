class Video < ActiveRecord::Base
  belongs_to :category
  has_many   :reviews, -> { order("created_at DESC")}
  has_many   :queue_items

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%")
  end

end
