class Team < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :projects, dependent: :destroy

  has_many :team_memberships, dependent: :destroy
  has_many :members, through: :team_memberships, source: :user
end
