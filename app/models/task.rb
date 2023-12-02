class Task < ApplicationRecord
  belongs_to :user
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id', optional: true
  has_many :comments, dependent: :destroy

  enum status: { not_started: "not_started", in_progress: "in_progress", completed: "completed" }

  enum priority_level: { low: 0, medium: 1, high: 2 }
  belongs_to :roster
end
