class User < ActiveRecord::Base

  has_many :reviews
  has_many :queue_items

  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email

  has_secure_password validations: false

  def positions_reorder
    queue_items.each_with_index do |item, index|
      item.update_attributes(position: index + 1)
    end
  end

  def video_in_queue?(video)
    reload.queue_items.map(&:video).include?(video)
  end

end
