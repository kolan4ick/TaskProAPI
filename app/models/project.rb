class Project < ApplicationRecord
  has_many :boards, dependent: :destroy
end
