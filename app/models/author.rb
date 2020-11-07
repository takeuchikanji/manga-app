class Author < ApplicationRecord
  has_many :comics, dependent: :destroy
  accepts_nested_attributes_for :comics

  validates :name, presence: true
end
