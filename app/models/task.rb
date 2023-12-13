class Task < ApplicationRecord
  belongs_to :user
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id', optional: true
  has_many :comments, dependent: :destroy

  enum status: { not_started: 0, in_progress: 1, completed: 2 }

  enum priority_level: { low: 0, medium: 1, high: 2 }
  belongs_to :roster
end
