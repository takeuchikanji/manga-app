class Author < ApplicationRecord
  has_many :comics, dependent: :destroy
  accepts_nested_attributes_for :comics, allow_destroy: true

  validates :name, presence: true
end
