# frozen_string_literal: true

module Types
  class TaskType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :description, String
    field :deadline, GraphQL::Types::ISO8601DateTime
    field :user_id, Integer, null: false
    field :assignee_id, Integer, null: false
    field :priority_level, TaskPriorityLevelType, null: false
    field :status, TaskStatusType, null: false
    field :completed_at, GraphQL::Types::ISO8601DateTime
    field :comments, [Types::CommentType], null: true
    field :position, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :roster_id, Integer, null: false
  end
end
