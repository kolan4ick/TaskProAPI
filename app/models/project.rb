class Project < ApplicationRecord
  has_many :boards, dependent: :destroy

  has_one_attached :icon
end
