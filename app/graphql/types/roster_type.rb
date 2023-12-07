# frozen_string_literal: true

module Types
  class RosterType < Types::BaseObject
    field :id, ID, null: false
    field :board_id, Integer, null: false
    field :title, String
    field :tasks, [Types::TaskType], null: true
    field :position, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def tasks
      object.tasks.order(position: :asc)
    end
  end
end
