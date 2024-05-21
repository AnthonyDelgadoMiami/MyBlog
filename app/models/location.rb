class Location < ApplicationRecord
  has_many :users, dependent: :delete_all

  scope :ByName, -> (name) { where("name LIKE ?", '%' + name + '%')}
  scope :search, -> (query) { where("name LIKE :query OR id LIKE :query", query: "%#{query}%") }
  validates :name, presence: true
end
