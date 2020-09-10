class Genre < ApplicationRecord
  has_many :comic_genres
  has_many :comics, through: :comic_genres
  validates :genre, presence: true, uniqueness: true
end
