class Category < ApplicationRecord
  validates :color, presence: true
  validates :title, presence: true

  has_many :videos
end
