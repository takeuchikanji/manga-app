class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 10 }

  has_many :bookmarks, dependent: :destroy
  has_many :comics, through: :bookmarks

  has_many :comments, dependent: :destroy
end
