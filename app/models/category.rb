class Category < ApplicationRecord
  validates :color, presence: true
  validates :title, presence: true
end
