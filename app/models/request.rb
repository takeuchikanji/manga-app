class Request < ApplicationRecord
  belongs_to :user
  validates :comicname, presence: true
  validates :authorname, presence: true
  validates :comment, presence: true
end
