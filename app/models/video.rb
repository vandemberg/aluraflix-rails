class Video < ApplicationRecord
  validates :title, presence: true, length: { in: 2..60 }
  validates :description, presence: true, length: { in: 6..255 }
  validates :url, presence: true, format: { with: URI.regexp }, allow_blank: true

  belongs_to :category
end
