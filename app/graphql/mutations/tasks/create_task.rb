# frozen_string_literal: true

module Mutations
  module Tasks
    class CreateTask < BaseMutation
      field :task, Types::TaskType, null: false

      argument :title, String, required: false
      argument :description, String, required: false
      argument :deadline, GraphQL::Types::ISO8601DateTime, required: false
      argument :user_id, Integer, required: true
      argument :assignee_id, Integer, required: true
      argument :priority_level, Types::TaskPriorityLevelType, required: false
      argument :roster_id, Integer, required: true
      argument :status, Types::TaskStatusType, required: false

      def resolve(**task_input)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        task = Task.new(task_input)

        raise GraphQL::ExecutionError, task.errors.full_messages.join(', ') unless task.save

        { task: }
      end
    end
  end
end
