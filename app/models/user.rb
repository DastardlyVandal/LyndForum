class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :streams, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :announcements, dependent: :destroy
  has_many :votes, dependent: :destroy
end
