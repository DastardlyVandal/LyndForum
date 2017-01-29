class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_length_of :name, maximum: 20

  has_many :streams, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :announcements, dependent: :destroy
  has_many :votes, dependent: :destroy

  def active_for_authentication?
      super && !self.banned
  end

  def inactive_message
      # Specify this case, in the event that there is
      # another issue with the account, it won't mislead them
      if self.banned
          "You've been banned."
      end
  end
end
