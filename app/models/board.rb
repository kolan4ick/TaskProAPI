class Board < ApplicationRecord
  belongs_to :project
  has_many :lists, dependent: :destroy
end
