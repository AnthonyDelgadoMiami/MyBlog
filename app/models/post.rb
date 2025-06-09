
class Post < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 280 }
  validates :user_id, presence: true
  
  scope :recent, -> { order(created_at: :desc) }
  scope :search, -> (query) { where("content LIKE ?", "%#{query}%") }
end
