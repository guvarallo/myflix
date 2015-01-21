class User < ActiveRecord::Base

  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items
  has_many :relationships
  has_many :relations, through: :relationships
  has_many :inverse_relationships, class_name: "Relationship", foreign_key: "relation_id"
  has_many :followers, through: :inverse_relationships, source: :user

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

  def following_user?(user)
    relationships.map(&:relation).include?(user)
  end

  def can_follow?(user)
    !(self.following_user?(user) || self == user)
  end

end
