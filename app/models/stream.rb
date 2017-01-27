class Stream < ApplicationRecord
    belongs_to :board
    belongs_to :user
    has_many :posts, dependent: :destroy
end
