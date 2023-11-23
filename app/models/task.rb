class Task < ApplicationRecord
  belongs_to :user
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id', optional: true
  has_many :comments, dependent: :destroy

  belongs_to :list
end
