class Board < ApplicationRecord

    has_many :streams, dependent: :destroy
end
