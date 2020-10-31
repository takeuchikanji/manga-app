class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :comic
  validates :user_id, uniqueness: { scope: :comic_id }   ## userとitemのidの組み合わせは一意
end
