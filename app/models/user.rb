class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks
  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id'

  has_many :notifications

  has_many :team_memberships, dependent: :destroy
  has_many :teams, through: :team_memberships

  has_many :owned_teams, class_name: 'Team', foreign_key: 'owner_id'
end
