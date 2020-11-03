class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :comic
  validates :text, presence: true, length: { maximum: 100 }
end
