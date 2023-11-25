class Board < ApplicationRecord
  belongs_to :project
  has_many :rosters, dependent: :destroy
end
