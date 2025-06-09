class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  
  belongs_to :location

  
  validates :name, presence: true
  validates :email, presence: true, length: { minimum: 5, maximum: 255 },format: { with: VALID_EMAIL_REGEX }, uniqueness: false


  scope :search, -> (query) { where("name LIKE :query OR email LIKE :query OR id LIKE :query", query: "%#{query}%") }
  scope :ByName, -> (name) { where("name LIKE ?", '%' + name + '%')}
  scope :ByID, -> (id) {where("id like ?", '%' + id + '%')}
  scope :ByEmail, -> (email) {where("email LIKE ?", '%' + email + '%')}
end
