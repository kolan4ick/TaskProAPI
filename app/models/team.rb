class Team < ApplicationRecord
  belongs_to :user
  has_many :projects, dependent: :destroy

  has_many :team_memberships, dependent: :destroy
  has_many :members, through: :team_memberships, source: :user
end
