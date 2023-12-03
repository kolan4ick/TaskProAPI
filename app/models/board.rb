class Board < ApplicationRecord
  belongs_to :project
  has_many :rosters, dependent: :destroy

  has_one_attached :cover_photo
end
