# frozen_string_literal: true

module Mutations
  module Tasks
    class CreateTask < BaseMutation
      field :task, Types::TaskType, null: false

      argument :title, String, required: false
      argument :description, String, required: false
      argument :deadline, GraphQL::Types::ISO8601DateTime, required: false
      argument :assignee_id, Integer, required: true
      argument :priority_level, Types::TaskPriorityLevelType, required: false
      argument :roster_id, Integer, required: true
      argument :status, Types::TaskStatusType, required: false
      argument :position, Integer, required: false

      def resolve(**task_input)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        user = context[:current_user]

        task = user.tasks.build(task_input)

        # Set display_order to the last one
        task.position = Task.maximum(:position).to_i + 1

        raise GraphQL::ExecutionError, task.errors.full_messages.join(', ') unless task.save

        # TODO: Create a notification for the assignee

        { task: }
      end
    end
  end
end
