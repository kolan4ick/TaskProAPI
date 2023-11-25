# frozen_string_literal: true

module Types
  class TaskInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :title, String, required: false
    argument :description, String, required: false
    argument :deadline, GraphQL::Types::ISO8601DateTime, required: false
    argument :user_id, Integer, required: false
    argument :assignee_id, Integer, required: false
    argument :priority_level, Integer, required: false
    argument :status, Integer, required: false
    argument :completed_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :created_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :updated_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :roster_id, Integer, required: false
  end
end
