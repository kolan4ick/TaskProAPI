# frozen_string_literal: true

module Types
  class CommentInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :content, String, required: false
    argument :user_id, Integer, required: false
    argument :task_id, Integer, required: false
    argument :created_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :updated_at, GraphQL::Types::ISO8601DateTime, required: false
  end
end
