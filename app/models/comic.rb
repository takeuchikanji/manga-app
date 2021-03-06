class Comic < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :booknumber
  belongs_to_active_hash :recommend
  
  belongs_to :author
  has_many :comic_genres, dependent: :destroy
  has_many :genres, through: :comic_genres
  accepts_nested_attributes_for :comic_genres

  validates :name, presence: true
  validates :image, presence: true
  validates :number_of_books, presence: true
  validates :summary, presence: true
  validates :review, presence: true
  validates :name_kana, presence: true

  mount_uploader :image, ImageUploader

  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks

  has_many :comments, dependent: :destroy
end
