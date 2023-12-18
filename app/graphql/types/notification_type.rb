# frozen_string_literal: true

module Types
  class NotificationType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :content_uk, String
    field :content_en, String
    field :task, Types::TaskType, null: false
    field :read, Boolean
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :task_id, Integer, null: false
  end
end
